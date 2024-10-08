import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ActivityScreen(),
    );
  }
}

class ActivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ActivityItem(
            title: 'Mirissa Beach - Coconut Tree Hill',
            date: 'Apr 22 | 11:42 AM',
            price: 'LKR 100,030',
          ),
          ActivityItem(
            title: 'Hideaway Trials',
            date: 'Apr 22 | 11:42 PM',
            price: 'LKR 41,000 (Hotel Charges + VAT)',
          ),
          ActivityItem(
            title: 'Naachiyar - Authentic Sri Lankan Buffet',
            date: 'Apr 22 | 11:42 PM',
            price: 'LKR 6,800 (Guide | Vimosh V)',
          ),
          ActivityItem(
            title: 'Guide Charges',
            date: 'Apr 22 | 11:42 PM',
            price: 'LKR 8,000 (2 hrs | per hour)',
          ),
          ActivityItem(
            title: 'Adventure Activities',
            date: 'Apr 22 | 11:42 PM',
            price: 'LKR 2,000 (Flying Ravana)',
          ),
          ActivityItem(
            title: 'Bullock Cart Ride',
            date: 'Apr 22 | 11:42 PM',
            price: 'LKR 2,000',
          ),
        ],
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final String title;
  final String date;
  final String price;

  ActivityItem({
    required this.title,
    required this.date,
    required this.price,
  });

  @override
    @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Added this line
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  Text(date),
                  Text(price, style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            
            Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {},
                child: Text('Rebook'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}