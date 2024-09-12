import 'package:flutter/material.dart';

class TripDatesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(Icons.calendar_month_sharp, color: Color(0xFF2A966C)),
          SizedBox(width: 8),
          Text('5 days', style: TextStyle(fontSize: 16)),
          Spacer(),
          TextButton(
            onPressed: () {
              // Navigate to date picker
            },
            child: Text('Change', style: TextStyle(color: Color(0xFF2A966C))),
          ),
        ],
      ),
    );
  }
}
