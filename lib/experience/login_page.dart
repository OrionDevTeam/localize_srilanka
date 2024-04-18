import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0x00000fff), Color(0x00000fff), Color(0x00000fff)],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              SizedBox(
                height: 320, // Set the height as needed
                // Set the width as needed
                child: Image.asset('assets/vimosh/image.png'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Plan Your Perfect SriLanka Trip',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 47, 47, 47),
                  fontFamily: 'Popins',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Immerse yourself in the vibrant culture and warm hospitality of Sri Lanka,',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(157, 47, 47, 47),
                  fontFamily: 'Popins',
                ),
              ),
              const Text(
                'where every corner reveals a new adventure.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Color.fromARGB(157, 47, 47, 47),
                  fontFamily: 'Popins',
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2A966C), // Color of the first dot
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey, // Color of the second dot
                    ),
                  ),
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey, // Color of the third dot
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Add onPressed logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2A966C), // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
