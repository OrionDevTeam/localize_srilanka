import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  final DateTime date;
  final TimeOfDay time;
  final String packageName;
  final String imageURL;

  BookingPage({
    required this.date,
    required this.time,
    required this.packageName,
    required this.imageURL,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: Center(
        child: Text(
          'Date: ${date.toLocal().toShortDateString()}\nTime: ${time.format(context)}',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

extension DateTimeExtensions on DateTime {
  String toShortDateString() {
    return '${this.day}-${this.month}-${this.year}';
  }
}