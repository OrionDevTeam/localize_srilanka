import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int currentIndex;
  final int totalDots;

  ProgressIndicatorWidget(
      {required this.currentIndex, required this.totalDots});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: currentIndex == index ? 12.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: currentIndex == index ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }
}
