import 'package:flutter/material.dart'; // Corrected import statement

import 'package:velocity_x/velocity_x.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  // ignore: constant_identifier_names
  //static const String KEYWORD = "login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              fit: BoxFit.fill,
              image: AssetImage("assets/images/Welcome_Image.jpg"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: "Smart Fitness App"
                    .text
                    .bold
                    .color(Colors.white)
                    .xl4
                    .make(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 250),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: "Let's Move".text.color(Colors.white).bold.xl4.make(),
              ),
            ),
            Center(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20, right: 20, bottom: 190),
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Fitness and Wellness for you Anytime , Anywhere",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        backgroundColor: Colors.white.withOpacity(0.1)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: Container(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 60,
                  width: 190,
                  child: ElevatedButton(
                    onPressed: () async {
                      // var sharedpref = await SharedPreferences.getInstance();
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => LoginPage()),
                      //  );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: StadiumBorder(),
                    ),
                    child: "Get Started".text.xl3.make(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
