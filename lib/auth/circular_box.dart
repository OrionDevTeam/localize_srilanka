import 'package:flutter/material.dart';

class CircularTextBox extends StatelessWidget {
  final String label;

  const CircularTextBox({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500.0,
      height: 50.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.black),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          hintText: label,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
