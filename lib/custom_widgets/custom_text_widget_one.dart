import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextWidget1 extends StatelessWidget {
  String text;

  CustomTextWidget1({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}
