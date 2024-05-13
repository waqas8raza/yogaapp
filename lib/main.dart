import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:yogaapp/firebase_options.dart';
import 'package:yogaapp/src/Screens/admin/add_course.dart';
import 'package:yogaapp/src/Screens/pages/auth_check_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(fontFamily: "Poppins"),
        debugShowCheckedModeBanner: false,
        home: kIsWeb
            ? const AddCourseScreen()
            : const AuthenticationCheckerPage());
  }
}
