import 'package:flutter/material.dart';
import 'circular_box.dart' ;
import 'otp_page.dart';
import 'login_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/varun/traveling.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 70.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Welcome! Please enter your Name, email and password to create your account.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: 1.0,
            color: Colors.grey,
          ),
          const Expanded(
            child: SignUpForm(),
          ),
        ],
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularTextBox(label: 'Name'),
          const SizedBox(height: 20.0),
          const CircularTextBox(label: 'Email'),
          const SizedBox(height: 20.0),
          const CircularTextBox(label: 'Password'),
          const SizedBox(height: 20.0),
          const CircularTextBox(label: 'Re-enter Password'),
          const SizedBox(height: 60.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OtpPage()),
              );
            },
            style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 20.0), // Adjust the padding as needed
            ),
             child: const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color : Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
                  const Text('Already have an account ?',
                  style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Poppins',
                  color : Colors.grey,
              ),),
              const SizedBox(width:20.0),
                  GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
            },
             child: const Text(
              'Login',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color : Colors.black,
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

