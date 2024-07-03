import 'package:flutter/material.dart';


class ServiceCard extends StatelessWidget {
  final String day;
  final String time;
  final String title;
  final String description;
  final String attendees;
  final String imageRef; // Add image reference

  ServiceCard({
    required this.day,
    required this.time,
    required this.title,
    required this.description,
    required this.attendees,
    required this.imageRef, // Initialize image reference
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjust height as needed
      margin: EdgeInsets.symmetric(vertical: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: NetworkImage(imageRef),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add avatars for attendees
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage('URL to Attendee\'s image'), // Add the actual image URL
                      ),
                      SizedBox(width: 4.0),
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage('URL to Attendee\'s image'), // Add the actual image URL
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        attendees,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}