import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'application_detail.dart';
import '../visa/application/visa_application1.dart';

class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Your Applications',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: const ApplicationsList(),
    );
  }
}

class ApplicationsList extends StatefulWidget {
  const ApplicationsList({super.key});

  @override
  _ApplicationsListState createState() => _ApplicationsListState();
}

class _ApplicationsListState extends State<ApplicationsList> {
  late User _loggedInUser;

  @override
  void initState() {
    super.initState();
    _loggedInUser = FirebaseAuth.instance.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('visa applications')
          .where('userRef',
              isEqualTo: FirebaseFirestore.instance
                  .collection('users')
                  .doc(_loggedInUser.uid))
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final applications = snapshot.data!.docs;

        if (applications.isEmpty) {
          return const Center(child: Text('No applications found.'));
        }

        return ListView.builder(
          itemCount: applications.length,
          itemBuilder: (context, index) {
            final doc = applications[index];
            final status = doc['status'] as String;
            final applicationId = doc.id;

            // Extract the visa reference from the document
            final visaRef = doc['visa'] as DocumentReference;

            // Define status color
            Color statusColor;
            switch (status) {
              case 'Processing':
                statusColor = Colors.amber.withOpacity(0.8);
                break;
              case 'Ongoing':
                statusColor = Colors.grey;
                break;
              case 'Rejected':
                statusColor = Colors.red;
                break;
              case 'Approved':
                statusColor = Colors.green;
                break;
              default:
                statusColor = Colors.black;
            }

            return GestureDetector(
              onTap: () async {
                if (status == 'Ongoing') {
                  final visaDoc = await visaRef.get();
                  final visaData = visaDoc.data() as Map<String, dynamic>? ?? {};
                  // Navigate to the Visa Application Form page if status is "Ongoing"
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VisaApplicationFormPage(visa: visaDoc), // Replace with the correct page
                    ),
                  );
                } else {
                  // Fetch the visa document data if the status is not "Ongoing"
                  final visaDoc = await visaRef.get();
                  final visaData = visaDoc.data() as Map<String, dynamic>? ?? {};

                  // Navigate to the Application Details screen for other statuses
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApplicationDetailsScreen(
                        visaData: visaData,
                        status: status,
                      ),
                    ),
                  );
                }
              },
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: statusColor),
                        image: DecorationImage(
                          image: AssetImage('assets/visa/application.jpg'), // Ensure this path is correct
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.7), // Adjust opacity as needed
                            BlendMode.lighten,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Application id: $applicationId',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 8.0),
                          decoration: BoxDecoration(
                            color: statusColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Status: $status',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

// Placeholder screens for navigation
class VisaApplicationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visa Application')),
      body: const Center(child: Text('Visa Application Details')),
    );
  }
}
