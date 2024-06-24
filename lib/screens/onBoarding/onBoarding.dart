import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final String imagePath;
  final String destinationName;
  final String buttonText;
  final int currentIndex;

  OnboardingScreen({
    required this.imagePath,
    required this.destinationName,
    required this.buttonText,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black45,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pick Your Destination',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Image.asset(
                      imagePath,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    destinationName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  ProgressIndicatorWidget(
                      currentIndex: currentIndex, totalDots: 3),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(buttonText),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
            color: currentIndex == index ? Colors.white : Colors.grey,
            borderRadius: BorderRadius.circular(4.0),
          ),
        );
      }),
    );
  }
}
