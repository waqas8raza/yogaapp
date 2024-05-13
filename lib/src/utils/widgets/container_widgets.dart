import 'package:flutter/material.dart';
import 'package:yogaapp/src/utils/app_styles.dart';

import '../app_colors.dart';

class ContainerWidget extends StatelessWidget {
  ContainerWidget(
      {super.key, required this.title, required this.onPressed, this.trailing});

  final String title;
  Widget? trailing;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
                colors: [Colors.blueAccent, Colors.white])),
        child: Center(
          child: ListTile(
              subtitle: trailing,
              title: Text(
                title,
                style: AppTextStyle.normalTextStyle,
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 40,
                color: AppColors.iconColor,
              ),
              onTap: onPressed),
        ),
      ),
    );
  }
}
