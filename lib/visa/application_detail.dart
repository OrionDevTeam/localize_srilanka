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
    String firstName = visaData['firstName'] ?? 'First name not provided';
    String surname = visaData['surname'] ?? 'Surname not provided';
    String dob = visaData['dob'] ?? 'Date of birth not provided';
    String address = visaData['address'] ?? 'Address not provided';
    String passportNumber = visaData['passportNumber'] ?? 'Passport number not provided';
    String passportIssueDate = visaData['passportIssueDate'] ?? 'Passport issue date not provided';
    String passportExpiryDate = visaData['passportExpiryDate'] ?? 'Passport expiry date not provided';
    String nationality = visaData['nationality'] ?? 'Nationality not provided';
    String durationOfStay = visaData['durationOfStay'] ?? 'Duration of stay not provided';
    // Add more fields as necessary

    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/visa/immigration.jpg'), // Replace with your image asset
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.6), // Adjust opacity as needed
                  BlendMode.lighten,
                ),
              ),
            ),
          ),
          // Back button and status container in a Row
          Positioned(
            top: 55, // Adjust the top position as needed
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    height: 55,
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.9), // Slightly transparent background
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Status: $statusText',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Details container
          Positioned(
            top: 120, // Position below the back button and status container
            left: 16,
            right: 16,
            bottom: 16,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8), // Slightly transparent background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'First Name: $firstName',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Surname: $surname',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Date of Birth: $dob',
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
                  const SizedBox(height: 8.0),
                  Text(
                    'Passport Issue Date: $passportIssueDate',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Passport Expiry Date: $passportExpiryDate',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Nationality: $nationality',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Duration of Stay: $durationOfStay',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  // Add other fields from the visa data here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
