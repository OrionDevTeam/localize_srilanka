import 'package:flutter/material.dart';

import 'onBoarding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingPage(),
    );
  }
}

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
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
