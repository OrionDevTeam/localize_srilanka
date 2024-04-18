import 'package:flutter/material.dart';
import 'package:localize_sl/home.dart';

class FinalPage extends StatelessWidget {
  const FinalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Success'),
      ),
      body: Center(
        child: 
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                    Image.asset(
                      'assets/varun/password.png', // Your image asset path
                      width: 500, // Set the width of the image
                      height: 500, // Set the height of the image
                    ),
            const Text(
              'Success',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Congratulations! You have been successfully authenticated',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ),
                  (route) => false,
                );
              },
            style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 20.0),
            backgroundColor: const Color.fromRGBO(42, 150, 108, 1), // Adjust the padding as needed
            ),
             child: const Text(
              'Continue',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color : Colors.white,
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }
}
