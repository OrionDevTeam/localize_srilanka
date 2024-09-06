import 'package:flutter/material.dart';

class ApplicationDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> visaData;
  final String status;

  const ApplicationDetailsScreen({
    super.key,
    required this.visaData,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    // Determine status color
    Color statusColor;
    String statusText;
    switch (status) {
      case 'Processing':
        statusColor = Colors.amber.withOpacity(0.8);
        statusText = 'Processing';
        break;
      case 'Ongoing':
        statusColor = Colors.grey;
        statusText = 'Ongoing';
        break;
      case 'Rejected':
        statusColor = Colors.red;
        statusText = 'Rejected';
        break;
      case 'Approved':
        statusColor = Colors.green;
        statusText = 'Approved';
        break;
      default:
        statusColor = Colors.black;
        statusText = 'Unknown';
    }

    // Extract visa details with default values
    String name = visaData['name'] ?? 'Name not provided';
    String address = visaData['address'] ?? 'Address not provided';
    String passportNumber = visaData['passportNumber'] ?? 'Passport number not provided';
    // Add more fields as necessary

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/visa/application.jpg'), // Replace with your image asset
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.4), // Adjust opacity as needed
                  BlendMode.darken,
                ),
              ),
            ),
          ),
          Column(
            children: [
              // Status container
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16.0),
                color: statusColor.withOpacity(0.6), // Slightly transparent background
                child: Text(
                  'Status: $statusText',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Spacer to push the details container down
              const SizedBox(height: 16.0),
              // Details container
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8), // Slightly transparent background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: $name',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Address: $address',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Passport Number: $passportNumber',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      // Add other fields from the visa data here
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
