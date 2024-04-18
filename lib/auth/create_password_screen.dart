import 'package:flutter/material.dart';
import 'circular_box.dart';
import 'final_page.dart' ;

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Password'),
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
                        padding: EdgeInsets.only(right: 250.0),
                      child: Text(
                        'Create Password',
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
                        'Must contain at least one number. Minimum 8 characters',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      ),
                      
                      ),
                      const SizedBox(height : 30.0),
                      const CircularTextBox(label: 'Password'),
                      const SizedBox(height: 20.0),
                      const CircularTextBox(label: 'Re-enter Password'),
                      const SizedBox(height: 60.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const FinalPage()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 20.0),
                        backgroundColor: const Color.fromRGBO(42, 150, 108, 1), // Adjust the padding as needed
                        ),
                        child: const Text(
                          'Create Password',
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}