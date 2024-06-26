import 'package:flutter/material.dart';

class NeedHelpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Need Help'),
      ),
      body: HelpContent(),
    );
  }
}

class HelpContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Email: example@example.com',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8.0),
          Text(
            'Phone: +1234567890',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}


