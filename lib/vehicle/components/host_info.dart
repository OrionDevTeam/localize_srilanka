import 'package:flutter/material.dart';

class HostInfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF2A966C),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(
                  'assets/vimosh/g6.JPG'), // Placeholder for host image
              radius: 30,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Felicia Lopez',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text('All-Star Host | 139 Trips'),
                Text('Joined Sep 2020'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
