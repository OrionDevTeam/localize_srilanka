import 'package:flutter/material.dart';
import 'package:localize_sl/guide_profile.dart';
import 'circular_box.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white, // Left section color
                  child: Center(
                    child: Image.asset(
                      'assets/varun/password.png', // Your image asset path
                      width: 500, // Set the width of the image
                      height: 500, // Set the height of the image
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.white, // Right section color
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 100.0),
                      child: Text(
                        'Welcome Back !',
                        style: TextStyle(
                          fontSize: 50.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ),
                      const SizedBox(height: 10),
                      const Padding(
                        padding: EdgeInsets.only(right: 100.0),
                        child:  Text(
                        'Happy to see you again! Please enter your email and password to login to your account.',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      
                      ),
                      const SizedBox(height : 50.0),
                      const CircularTextBox(label: 'Email'),
                      const SizedBox(height: 20.0),
                      const CircularTextBox(label: 'Password'),
                      const SizedBox(height: 60.0),
                                ElevatedButton(
            onPressed: () {
              // pop all the screens and navigate to home screen
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const GuideProfilePage(),
                ),
                (route) => false,
              );
            },
            style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 15.0),
            backgroundColor: const Color.fromRGBO(42, 150, 108, 1), // Adjust the padding as needed
            ),
             child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color : Colors.white,
              ),
            ),
          ),

            const SizedBox(height: 16.0),
            const Text("------------------------- Or ----------------------------------"),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                'assets/varun/google_logo.png', // Replace 'google_logo.png' with the actual path to your Google icon image asset
                height: 24, // Adjust the height as needed
                width: 24, // Adjust the width as needed
              ),
              label: const Text('Login with Google', style: TextStyle(color: Colors.black)),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.white), // Background color
                padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.symmetric(horizontal: 60.0,vertical: 20.0),
                ),
         ),
                ),
                    ],
                  ),
          ),
              ),
            ],
          ),
        ],
    ),
    );
  }
}