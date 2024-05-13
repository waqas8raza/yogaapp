import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../models/yoga_model.dart';
import '../../services/firebase_service.dart';

class VideoScreen extends StatefulWidget {
  final String courseId;
  final String levelName;
  final String dayName;
  final FirebaseService _firebaseService = FirebaseService();

  VideoScreen({
    required this.courseId,
    required this.levelName,
    required this.dayName,
  });

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  List<String>? _videoUrls;
  int _currentIndex = 0;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  void _initializePlayer() async {
    await _fetchVideoUrls();
    if (_videoUrls != null && _videoUrls!.isNotEmpty) {
      _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(
          _videoUrls![_currentIndex],
        )!,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );
    }
  }

  Future<void> _fetchVideoUrls() async {
    try {
      List<YogaCourse> courses =
          await widget._firebaseService.getCoursesFromFirestore();
      YogaCourse? selectedCourse =
          courses.firstWhere((course) => course.courseId == widget.courseId);
      Level? selectedLevel = selectedCourse.levels
          .firstWhere((level) => level.levelName == widget.levelName);
      Day? selectedDay =
          selectedLevel.days.firstWhere((day) => day.dayName == widget.dayName);
      List<String> videoUrls =
          selectedDay.videos.map((video) => video.videoUrl).toList();
      setState(() {
        _videoUrls = videoUrls;
      });
    } catch (e) {
      print('Error fetching video URLs: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_videoUrls == null || _videoUrls!.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Videos'),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Videos (${_currentIndex + 1} of ${_videoUrls!.length})',
        ),
      ),
      body: Column(
        children: [
          _videoUrls!.isNotEmpty
              ? YoutubePlayer(
                  controller: _controller,
                  liveUIColor: Colors.amber,
                  onEnded: (_) => _updateProgress(),
                )
              : const SizedBox(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _currentIndex > 0 ? _playPreviousVideo : null,
                child: const Icon(Icons.skip_previous),
              ),
              ElevatedButton(
                onPressed: _currentIndex < _videoUrls!.length - 1
                    ? _playNextVideo
                    : null,
                child: const Icon(Icons.skip_next),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _updateProgress,
            child: const Text('Update Progress'),
          ),
        ],
      ),
    );
  }

  void _playPreviousVideo() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _controller.load(_videoUrls![_currentIndex]);
      });
    }
  }

  void _playNextVideo() {
    if (_currentIndex < _videoUrls!.length - 1) {
      setState(() {
        _currentIndex++;
        _controller.load(_videoUrls![_currentIndex]);
      });
    }
  }

  void _updateProgress() async {
    try {
      double progress = (_currentIndex + 1) / _videoUrls!.length * 100;
      String userId = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference progressDocRef = FirebaseFirestore.instance
          .collection('user_progress')
          .doc(userId)
          .collection('courses')
          .doc(widget.courseId);

      bool progressDocExists =
          await progressDocRef.get().then((doc) => doc.exists);

      if (!progressDocExists) {
        await progressDocRef.set({
          'progress': progress,
        });
      } else {
        await progressDocRef.update({
          'progress': progress,
        });
      }

      print('User progress updated successfully!');
    } catch (e) {
      print('Error updating user progress: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
