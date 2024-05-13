import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

import '../models/yoga_model.dart';

class FirebaseService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> uploadImage(Uint8List? imageBytes) async {
    if (imageBytes == null) return null;

    try {
      final String imageFileName = '${Uuid().v4()}.jpg';
      final Reference storageRef =
          _storage.ref().child('course_images/$imageFileName');

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
      );
      await storageRef.putData(imageBytes, metadata);

      final String imageUrl = await storageRef.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  Future<String> uploadVideo(File videoFile) async {
    try {
      final String videoFileName = '${Uuid().v4()}.mp4';
      final Reference storageRef =
          _storage.ref().child('course_videos/$videoFileName');
      await storageRef.putFile(videoFile);
      final String videoUrl = await storageRef.getDownloadURL();
      return videoUrl;
    } catch (e) {
      throw Exception('Error uploading video: $e');
    }
  }

  Future<void> uploadCourse(YogaCourse course) async {
    try {
      await _firestore.collection('courses').doc(course.courseId).set({
        'courseId': course.courseId,
        'courseName': course.courseName,
        'courseImage': course.courseImage,
        'gender': course.gender,
        'bodyShape': course.bodyShape,
        'levels': _serializeLevels(course.levels),
      });
    } catch (e) {
      throw Exception('Error uploading course: $e');
    }
  }

  List<Map<String, dynamic>> _serializeLevels(List<Level> levels) {
    return levels.map((level) {
      return {
        'levelName': level.levelName,
        'levelImage': level.levelImage, // Include levelImage field
        'days': _serializeDays(level.days),
      };
    }).toList();
  }

  List<Map<String, dynamic>> _serializeDays(List<Day> days) {
    return days.map((day) {
      return {
        'dayName': day.dayName,
        'videos': _serializeVideos(day.videos),
      };
    }).toList();
  }

  List<Map<String, dynamic>> _serializeVideos(List<Video> videos) {
    return videos.map((video) {
      return {
        'videoId': video.videoId,
        'videoUrl': video.videoUrl,
      };
    }).toList();
  }

  Future<List<YogaCourse>> getCoursesFromFirestore() async {
    List<YogaCourse> courses = [];

    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('courses').get();

      querySnapshot.docs.forEach((doc) {
        YogaCourse course = YogaCourse(
          bodyShape: doc['bodyShape'],
          courseId: doc['courseId'],
          courseName: doc['courseName'],
          courseImage: doc['courseImage'],
          levels: _parseLevels(doc['levels']),
          progress: 0.0,
          gender: doc['gender'], // Assuming progress is not stored in Firestore
        );
        courses.add(course);
      });

      return courses;
    } catch (e) {
      print('Error getting courses from Firestore: $e');
      return [];
    }
  }

  List<Level> _parseLevels(List<dynamic> levelsData) {
    return levelsData.map((levelData) {
      return Level(
        levelName: levelData['levelName'],
        levelImage: levelData['levelImage'],
        days: _parseDays(levelData['days']),
        progress: 0.0, // Assuming progress is not stored in Firestore
      );
    }).toList();
  }

  List<Day> _parseDays(List<dynamic> daysData) {
    return daysData.map((dayData) {
      return Day(
        dayName: dayData['dayName'],
        videos: _parseVideos(dayData['videos']),
        progress: 0.0, // Assuming progress is not stored in Firestore
      );
    }).toList();
  }

  List<Video> _parseVideos(List<dynamic> videosData) {
    return videosData.map((videoData) {
      return Video(
        videoId: videoData['videoId'],
        videoUrl: videoData['videoUrl'],
        progress: 0.0, // Assuming progress is not stored in Firestore
      );
    }).toList();
  }
}
