import 'package:flutter/material.dart';

class BookNowBar extends StatelessWidget {
  final String pricePerHour;

  const BookNowBar({Key? key, required this.pricePerHour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.circular(16),
      ), // Set the border radius for the top corners
      child: BottomAppBar(
        color: Color(0xFF2A966C), // Set the background color here
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                pricePerHour,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white), // Adjust text color for contrast
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle booking logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // Set the button color
                  foregroundColor: Color(0xFF2A966C), // Set the text color
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // Set the border radius
                  ),
                ),
                child: Text('Book Now'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
