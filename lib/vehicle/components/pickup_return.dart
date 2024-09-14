import 'package:flutter/material.dart';

class PickupReturnSection extends StatelessWidget {
  const PickupReturnSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          const Icon(Icons.location_on, color: Color(0xFF2A966C)),
          const SizedBox(width: 8),
          const Text('Mirissa', style: TextStyle(fontSize: 16)),
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
