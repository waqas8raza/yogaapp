import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../models/yoga_model.dart';
import '../../services/firebase_service.dart';

class AddCourseScreen extends StatefulWidget {
  const AddCourseScreen({super.key});

  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  Uint8List? _imageBytes;
  String _courseName = '';
  String gender = 'Male';
  // String? bodyShape;
  String selectedGender = 'Male';
  String selectedBodyShape = 'Dadal';

  final FirebaseService _firebaseService = FirebaseService();
  final picker = ImagePicker();

  List<Level> _levels = [];

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _imageBytes = imageBytes;
      });
    }
  }

  Future<void> _uploadCourse() async {
    if (_imageBytes != null &&
        _courseName.isNotEmpty &&
        _levels.isNotEmpty &&
        gender.isNotEmpty) {
      final courseId = const Uuid().v4(); // Generate unique course ID
      final course = YogaCourse(
        bodyShape: selectedGender,
        courseId: courseId,
        courseName: _courseName,
        courseImage: "", // Placeholder for the image URL
        levels: _levels,
        gender: selectedGender,
      );

      // Upload image to Firebase Storage
      final imageUrl = await _firebaseService.uploadImage(_imageBytes);
      if (imageUrl != null) {
        course.courseImage = imageUrl;

        // Upload course data to Firestore
        await _firebaseService.uploadCourse(course).whenComplete(() =>
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Course uploaded successfully'))));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error uploading image')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please fill all fields')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Course'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<String>(
              value: selectedGender,
              onChanged: (String? newValue) {
                setState(() {
                  selectedGender = newValue!;
                });
              },
              items: <String>['Male', 'Female']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            DropdownButton<String>(
              value: selectedBodyShape,
              onChanged: (String? newValue) {
                setState(() {
                  selectedBodyShape = newValue!;
                });
              },
              items: <String>['Dadal', 'fadal']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            // TextField(
            //   onChanged: (value) => gender = value,
            //   decoration: const InputDecoration(labelText: 'Gender'),
            // ),
            TextField(
              onChanged: (value) => _courseName = value,
              decoration: const InputDecoration(labelText: 'Course Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 20),
            if (_imageBytes != null) ...[
              Image.memory(
                _imageBytes!,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddLevelsScreen(
                        onLevelsAdded: (levels) {
                          setState(() {
                            _levels = levels;
                          });
                        },
                      ),
                    ),
                  );
                },
                child: const Text('Add Levels'),
              ),
            ],
            const SizedBox(height: 20),
            if (_levels.isNotEmpty) ...[
              ElevatedButton(
                onPressed: _uploadCourse,
                child: const Text('Upload Course'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AddLevelsScreen extends StatefulWidget {
  final Function(List<Level>) onLevelsAdded;

  const AddLevelsScreen({super.key, required this.onLevelsAdded});

  @override
  _AddLevelsScreenState createState() => _AddLevelsScreenState();
}

class _AddLevelsScreenState extends State<AddLevelsScreen> {
  final TextEditingController _levelNameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final List<Level> _levels = [];
  late FirebaseService _firebaseService; // Declare _firebaseService
  Uint8List? _levelImageBytes;

  // Initialize _firebaseService in initState
  @override
  void initState() {
    super.initState();
    _firebaseService = FirebaseService();
  }

  void _pickLevelImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final imageBytes = await pickedFile.readAsBytes();
      setState(() {
        _levelImageBytes = imageBytes;
      });
    }
  }

  void _addLevel() async {
    final levelName = _levelNameController.text.trim();
    if (levelName.isNotEmpty && _levelImageBytes != null) {
      final imageUrl = await _firebaseService.uploadImage(_levelImageBytes);
      if (imageUrl != null) {
        setState(() {
          _levels.add(Level(
            levelName: levelName,
            levelImage: imageUrl,
            days: [],
          ));
          _levelNameController.clear();
          _levelImageBytes = null; // Clear image selection for next level
        });
      } else {
        // Handle image upload failure
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload level image')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Levels'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _levelNameController,
              decoration: const InputDecoration(labelText: 'Level Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickLevelImage,
              child: const Text('Select Image'),
            ),
            if (_levelImageBytes != null) ...[
              const SizedBox(height: 20),
              Image.memory(
                _levelImageBytes!,
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addLevel,
              child: const Text('Add Level'),
            ),
            const SizedBox(height: 20),
            if (_levels.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: _levels.length,
                  itemBuilder: (context, index) {
                    final level = _levels[index];
                    return ListTile(
                      title: Text(level.levelName),
                      subtitle: level.levelImage.isNotEmpty
                          ? Image.network(
                              level.levelImage,
                              height: 50,
                              width: 50,
                              fit: BoxFit.cover,
                            )
                          : null,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddDaysScreen(
                              level: level,
                              onDaysAdded: (days) {
                                setState(() {
                                  _levels[index] = Level(
                                    levelName: level.levelName,
                                    levelImage: level.levelImage,
                                    days: days,
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.onLevelsAdded(_levels);
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AddDaysScreen extends StatefulWidget {
  final Level level;
  final Function(List<Day>) onDaysAdded;

  const AddDaysScreen(
      {super.key, required this.level, required this.onDaysAdded});

  @override
  _AddDaysScreenState createState() => _AddDaysScreenState();
}

class _AddDaysScreenState extends State<AddDaysScreen> {
  final TextEditingController _dayNameController = TextEditingController();
  final List<Day> _days = [];

  void _addDay() {
    final dayName = _dayNameController.text.trim();
    if (dayName.isNotEmpty) {
      setState(() {
        _days.add(Day(dayName: dayName, videos: []));
        _dayNameController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Days for ${widget.level.levelName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _dayNameController,
              decoration: const InputDecoration(labelText: 'Day Name'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addDay,
              child: const Text('Add Day'),
            ),
            const SizedBox(height: 20),
            if (_days.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: _days.length,
                  itemBuilder: (context, index) {
                    final day = _days[index];
                    return ListTile(
                      title: Text(day.dayName),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddVideosScreen(
                              day: day,
                              onVideosAdded: (videos) {
                                setState(() {
                                  _days[index] = Day(
                                    dayName: day.dayName,
                                    videos: videos,
                                  );
                                });
                              },
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.onDaysAdded(_days);
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class AddVideosScreen extends StatefulWidget {
  final Day day;
  final Function(List<Video>) onVideosAdded;

  const AddVideosScreen(
      {super.key, required this.day, required this.onVideosAdded});

  @override
  _AddVideosScreenState createState() => _AddVideosScreenState();
}

class _AddVideosScreenState extends State<AddVideosScreen> {
  final TextEditingController _videoUrlController = TextEditingController();
  final List<Video> _videos = [];

  void _addVideo() {
    final videoUrl = _videoUrlController.text.trim();
    if (videoUrl.isNotEmpty) {
      setState(() {
        _videos.add(Video(videoId: const Uuid().v4(), videoUrl: videoUrl));
        _videoUrlController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Videos for ${widget.day.dayName}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _videoUrlController,
              decoration: const InputDecoration(labelText: 'Video URL'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addVideo,
              child: const Text('Add Video'),
            ),
            const SizedBox(height: 20),
            if (_videos.isNotEmpty) ...[
              Expanded(
                child: ListView.builder(
                  itemCount: _videos.length,
                  itemBuilder: (context, index) {
                    final video = _videos[index];
                    return ListTile(
                      title: Text(video.videoUrl),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  widget.onVideosAdded(_videos);
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
