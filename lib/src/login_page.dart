import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yogaapp/src/Screens/AimScreen.dart';
import 'package:yogaapp/src/signup_page.dart'; // Import the AimScreen class from the correct file path

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  // Function to handle sign-in
  Future<void> _signIn(
      BuildContext context, String email, String password) async {
    try {
      // Sign in with email and password using FirebaseAuth
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Navigate to the home screen after successful sign-in
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CoursesScreen()),
      );
    } catch (error) {
      // Handle sign-in errors
      print('Error signing in: $error');
      // You can display a snackbar or show an error dialog to the user here
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(),
              _inputField(context, _emailController, _passwordController),
              _forgotPassword(),
              _signup(context), // Pass context for navigation
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: [
        const Text(
          "Log in",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Create your account",
          style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
        )
      ],
    );
  }

  Widget _inputField(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(
            hintText: "Username",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 40),
        ElevatedButton(
          onPressed: () {
            // Call the _signIn function with the provided email and password
            _signIn(context, emailController.text, passwordController.text);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: Colors.pinkAccent,
          ),
          child: const Text(
            "Login",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _forgotPassword() {
    return TextButton(
      onPressed: () {
        // Implement forgot password logic here
      },
      child: const Text(
        "Forgot password?",
        style: TextStyle(color: Color(0xFF90CAF9)),
      ),
    );
  }

  Widget _signup(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            // Navigate to sign-up page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignUpPage()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.pinkAccent),
          ),
        )
      ],
    );
  }
}
