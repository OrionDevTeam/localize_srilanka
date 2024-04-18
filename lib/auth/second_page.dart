import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage('assets/varun/middle.jpg'),
            height: 500.0,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: Text(
              'Localize SriLanka',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
            
          ),
          const Padding(
            padding: EdgeInsets.only(top: 1.0),
            child: Text(
              'A Sustainable Tourism Platform for Authentic Experiences',
              style: TextStyle(
                fontSize: 19.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w100,
                color : Colors.grey,
              ),
            ),
            
          ),
          const SizedBox(height: 16.0),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(42, 150, 108, 1),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
                    ),
                    child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
              ),
            ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpPage()),
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 100, vertical: 15.0),
                    ),
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
