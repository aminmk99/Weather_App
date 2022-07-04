// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomTextWidget2 extends StatelessWidget {
  String text;

  CustomTextWidget2({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade700),
    );
  }
}
