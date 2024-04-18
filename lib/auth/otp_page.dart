import 'package:flutter/material.dart';
import 'create_password_screen.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  String imageAssetPath = 'assets/varun/otp_image.png'; // Initial image asset path

  void changeImage() {
    setState(() {
      imageAssetPath = 'assets/varun/otp_image2.png'; // New image asset path
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verification Step'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                imageAssetPath, // Use the current image asset path
                // width: 300,
                // height: 300,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 500.0), // Adjust the left padding as needed
              child: 
              Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 50.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children:[
              Padding(
                padding: EdgeInsets.only(left: 550.0), // Adjust the right padding as needed
                child: Text(
                  'Enter the OTP sent to',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.grey,
                  ),
                ),
              ),
            SizedBox(width : 20.0),

                 Text('aadi@gmail.com',
                  style: TextStyle(
                  fontSize: 25.0,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color : Colors.black,
              ),
              ),
          
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OTPBox(controller: TextEditingController()),
                const SizedBox(width: 10),
                OTPBox(controller : TextEditingController()),
                const SizedBox(width: 10),
                OTPBox(controller : TextEditingController()),
                const SizedBox(width: 10),
                OTPBox(controller : TextEditingController()),
                const SizedBox(width: 10),
                OTPBox(controller : TextEditingController()),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Verify OTP logic here
                changeImage(); // Call the method to change the image
                // Future.delayed(const Duration(seconds: 2), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreatePasswordPage()
                  ),
                );
                // });
              },
              style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(42, 150, 108, 1),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 100, vertical: 15.0),
                          ),
              child: const Text('Verify',
              style : TextStyle(
                color: Colors.white,
                fontSize: 35.0,
              )),
            ),
                     const  SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                    const Text('Didn\'t you receive OTP ?',
                    style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Poppins',
                    color : Colors.grey,
                ),
                ),
                const SizedBox(width : 10.0),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    'Resend OTP',
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
            const SizedBox(height : 50.0),
          ],
        ),
      ),
    );
  }
}



class OTPBox extends StatelessWidget {
  final TextEditingController controller;

  const OTPBox({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.black),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 30,
        color: Colors.green),
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
        ),
      ),
    );
  }
}