import 'package:flutter/material.dart';

class AppName extends StatelessWidget {
  const AppName({
    super.key,
    this.fontSize = 40,
    this.color,
  });

  final double fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: 'Your',
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color ?? Colors.white,
        ),
        children: [
          TextSpan(
            text: 'Wine',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          TextSpan(
            text: 'House',
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: color ?? Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
