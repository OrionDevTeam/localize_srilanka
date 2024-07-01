import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  final String imagePath;
  final String destinationName;
  final String buttonText;
  final int currentIndex;

  const OnboardingScreen({super.key, 
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
                  const Text(
                    'Pick Your Destination',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(8.0),
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
                  const SizedBox(height: 10),
                  Text(
                    destinationName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ProgressIndicatorWidget(
                      currentIndex: currentIndex, totalDots: 3),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: Text(buttonText),
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

  const ProgressIndicatorWidget(
      {super.key, required this.currentIndex, required this.totalDots});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
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
