import 'package:flutter/material.dart';

import '../../models/yoga_model.dart';
import '../../services/firebase_service.dart';
import 'course_day_page.dart';

class CourseLevelsScreen extends StatefulWidget {
  final String courseId;

  CourseLevelsScreen({
    required this.courseId,
  });

  @override
  State<CourseLevelsScreen> createState() => _CourseLevelsScreenState();
}

class _CourseLevelsScreenState extends State<CourseLevelsScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Text(
            'Select Level',
            style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          FutureBuilder<List<YogaCourse>>(
            future: _firebaseService.getCoursesFromFirestore(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<YogaCourse>? courses = snapshot.data;
                if (courses != null && courses.isNotEmpty) {
                  YogaCourse selectedCourse = courses.firstWhere(
                      (course) => course.courseId == widget.courseId);
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: selectedCourse.levels.length,
                    itemBuilder: (context, index) {
                      Level level = selectedCourse.levels[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 4,
                          borderRadius: BorderRadius.circular(20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DayScreen(
                                    courseId: widget.courseId,
                                    levelName: level.levelName,
                                    levelImage: level.levelImage,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 170,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,
                                      opacity: 0.8,
                                      image: NetworkImage(level.levelImage)),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: ListTile(
                                  title: Text(
                                    level.levelName,
                                    style: const TextStyle(
                                        color: Colors.blueAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // Navigate to days screen passing course ID and level name
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DayScreen(
                                          courseId: widget.courseId,
                                          levelName: level.levelName,
                                          levelImage: level.levelImage,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text('No courses found.'));
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
