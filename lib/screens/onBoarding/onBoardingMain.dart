import 'package:flutter/material.dart';

import 'onBoarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);

  void _onPageChanged(int index) {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const [
          OnboardingScreen(
            imagePath: 'assets/vimosh/train.png',
            destinationName: 'Ella',
            buttonText: 'Explore Ella',
            currentIndex: 0,
          ),
          OnboardingScreen(
            imagePath: 'assets/varun/traveling.jpg',
            destinationName: 'Mirrisa',
            buttonText: 'Explore Mirrisa',
            currentIndex: 1,
          ),
          // Add more onboarding screens if needed
        ],
      ),
    );
  }
}
