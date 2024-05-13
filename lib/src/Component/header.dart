import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.grey,
            ),
            child: const Text(
              "Logo",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ).centered(),
          ),
          Row(
            children: [
              Image.asset("assets/images/notificationicon.png", height: 34,),
              const SizedBox(width: 20,),
              Image.asset("assets/images/account.png", height: 34,),

            ],
          ),


        ],
      ),
    );
  }
}
