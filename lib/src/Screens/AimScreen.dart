import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/yoga_model.dart';
import '../services/firebase_service.dart';
import '../utils/widgets/container_widgets.dart';
import 'pages/course_level_page.dart'; // Import the next screen

class CoursesScreen extends StatefulWidget {
  CoursesScreen({Key? key}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Courses'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [Colors.blueAccent, Colors.white],
                    ),
                  ),
                  child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Text(
                          'Error: ${snapshot.error}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        );
                      } else {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                foregroundImage: NetworkImage(
                                  snapshot.data!['imageUrl'],
                                ),
                              ),
                              const SizedBox(width: 20),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Hello!',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data!['username'] ?? 'User Name',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 15,
                                    ),
                                  ),
                                  Text(
                                    FirebaseAuth.instance.currentUser?.email ??
                                        'user@example.com',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            const Text(
              'Select Course',
              style: TextStyle(
                color: Colors.blueAccent,
                fontWeight: FontWeight.w500,
                fontSize: 25,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<YogaCourse>>(
                future: _firebaseService.getCoursesFromFirestore(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    List<YogaCourse>? courses = snapshot.data;
                    if (courses != null && courses.isNotEmpty) {
                      return ListView.builder(
                        itemCount: courses.length,
                        itemBuilder: (context, index) {
                          YogaCourse course = courses[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ContainerWidget(
                              title: course.courseName,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CourseLevelsScreen(
                                      courseId: course.courseId,
                                    ),
                                  ),
                                );
                              },
                              trailing: Text(
                                '${course.progress.toStringAsFixed(2)}%',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No courses found.'));
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
