import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localize_sl/home.dart';
import 'auth/second_page.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Get Started'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Expanded(
            child: Image(
              image: AssetImage('assets/varun/middle.jpg'),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 32.0),
            child: Text(
              'Plan Your Perfect Sri Lanka Trip',
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
              'Immerse yourself in the vibrant culture and warm hospitality of Sri Lanka, where every corner reveals a new adventure.',
              style: TextStyle(
                fontSize: 19.0,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w100,
                color: Colors.grey,
              ),
            ),
            
          ),
          Container(
            margin: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                    Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(255, 31, 228, 129),
                    ),
                  ),


                for (int i = 0; i < 3; i++)
                  Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 2.0),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
              ],
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
                        MaterialPageRoute(builder: (context) => const SecondPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(42, 150, 108, 1),
                      padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15.0),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 25.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomePage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 100, vertical: 15.0),
                    ),
                    child: const Text(
                      'Check Nearby Experiences',
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

