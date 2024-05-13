import 'package:flutter/material.dart';
import 'package:yogaapp/src/Screens/pages/cours_video_page.dart';
import 'package:yogaapp/src/utils/widgets/container_widgets.dart';

import '../../models/yoga_model.dart';
import '../../services/firebase_service.dart';

class DayScreen extends StatelessWidget {
  final String courseId;
  final String levelName;
  final String levelImage;
  final FirebaseService _firebaseService = FirebaseService();

  DayScreen(
      {required this.courseId,
      required this.levelName,
      required this.levelImage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blueAccent,
        title: const Text(
          'Days',
          style: TextStyle(
            color: Colors.blueAccent,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Material(
              elevation: 3,
              borderRadius: BorderRadius.circular(10),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          levelImage,
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        levelName,
                        style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<YogaCourse>>(
              future: _firebaseService.getCoursesFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<YogaCourse>? courses = snapshot.data;
                  if (courses != null && courses.isNotEmpty) {
                    YogaCourse? selectedCourse = courses.firstWhere(
                      (course) => course.courseId == courseId,
                    );

                    if (selectedCourse != null) {
                      Level? selectedLevel = selectedCourse.levels.firstWhere(
                        (level) => level.levelName == levelName,
                      );
                      if (selectedLevel != null) {
                        return ListView.builder(
                          itemCount: selectedLevel.days.length,
                          itemBuilder: (context, index) {
                            Day day = selectedLevel.days[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ContainerWidget(
                                  title: day.dayName,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => VideoScreen(
                                          courseId: courseId,
                                          levelName: levelName,
                                          dayName: day.dayName,
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          },
                        );
                      } else {
                        return Center(
                            child: Text(
                                'No days found for $levelName in the course.'));
                      }
                    } else {
                      return Center(
                          child: Text('No course found with ID: $courseId.'));
                    }
                  } else {
                    return const Center(child: Text('No courses found.'));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
