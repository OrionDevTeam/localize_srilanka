import 'package:flutter/material.dart';

class TripDatesSection extends StatelessWidget {
  const TripDatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          const Icon(Icons.calendar_month_sharp, color: Color(0xFF2A966C)),
          const SizedBox(width: 8),
          const Text('5 days', style: TextStyle(fontSize: 16)),
          const Spacer(),
          TextButton(
            onPressed: () {
              // Navigate to date picker
            },
            child: const Text('Change', style: TextStyle(color: Color(0xFF2A966C))),
          ),
        ],
      ),
    );
  }
}
