import 'package:blinktrack/theme.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  const Button({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 290,
      height: 50,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 17),
          ),
          style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: AppColors.primary, // 80% opacity

              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25)),
              ))),
    );
  }
}
