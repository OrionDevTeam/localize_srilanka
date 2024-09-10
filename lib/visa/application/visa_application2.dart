import 'package:flutter/material.dart';

class UploadDocumentPage extends StatelessWidget {
  final String firstName;
  final String surname;
  final String dob;
  final String nationality;
  final String passportNumber;
  final String passportIssueDate;
  final String passportExpiryDate;
  final String durationOfStay;

  const UploadDocumentPage({
    super.key,
    required this.firstName,
    required this.surname,
    required this.dob,
    required this.nationality,
    required this.passportNumber,
    required this.passportIssueDate,
    required this.passportExpiryDate,
    required this.durationOfStay,
  });

  // Add your document upload logic here, this is just a placeholder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                'Upload Documents',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Add buttons or fields to upload files here

            // Just a placeholder for uploaded documents
            const Text('Your photo'),
            GestureDetector(
              onTap: () {
                // Add logic to view or download the document
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.cloud_download),
                    SizedBox(width: 10),
                    Text('Upload your photo'),
                    Spacer(),
                    Icon(Icons.question_mark, color: Color(0xFF00BA72)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Passport Copy:'),
            GestureDetector(
              onTap: () {
                // Add logic to view or download the document
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.cloud_download),
                    SizedBox(width: 10),
                    Text('Upload your passport copy'),
                    Spacer(),
                    Icon(Icons.question_mark, color: Color(0xFF00BA72)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            const Text('Other Documents'),
            GestureDetector(
              onTap: () {
                // Add logic to view or download the document
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.cloud_download),
                    SizedBox(width: 10),
                    Text('Upload other documents'),
                    Spacer(),
                    Icon(Icons.question_mark, color: Color(0xFF00BA72)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  backgroundColor: const Color(0xFF00BA72),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Save and Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
