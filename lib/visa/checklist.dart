import 'package:flutter/material.dart';

class VisaDocumentsChecklist extends StatefulWidget {
  const VisaDocumentsChecklist({super.key});

  @override
  _VisaDocumentsChecklistState createState() => _VisaDocumentsChecklistState();
}

class _VisaDocumentsChecklistState extends State<VisaDocumentsChecklist> {
  // List of documents and their states (checked or not)
  final List<Map<String, dynamic>> documents = [
    {"title": "Passport", "isChecked": false},
    {"title": "Visa Application Form", "isChecked": false},
    {"title": "Passport-Sized Photographs", "isChecked": false},
    {"title": "Flight Itinerary", "isChecked": false},
    {"title": "Proof of Accommodation", "isChecked": false},
    {"title": "Financial Proof (Bank Statement)", "isChecked": false},
    {"title": "Travel Insurance", "isChecked": false},
    {"title": "Letter of Invitation (if applicable)", "isChecked": false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Required Documents",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2A966C),
              ),
            ),
            const SizedBox(height: 7),
            const Text(
              "Make sure you have these documents when going for the Visa appointment",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF2A966C),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: CheckboxListTile(
                      title: Text(documents[index]["title"]),
                      value: documents[index]["isChecked"],
                      onChanged: (bool? value) {
                        setState(() {
                          documents[index]["isChecked"] = value!;
                        });
                      },
                      activeColor: const Color(0xFF2A966C),
                      checkColor: Colors.white,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            // Submit Button
            // Center(
            //   child: ElevatedButton(
            //     onPressed: () {
            //       // Add your submission logic here
            //       _showSubmissionStatus();
            //     },
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: Color(0xFF2A966C), // Custom button color
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            //     ),
            //     child: Text(
            //       "Save",
            //       style: TextStyle(fontSize: 16, color: Colors.white),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  void _showSubmissionStatus() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Checklist Status"),
          content: const Text("Visa document checklist submitted successfully."),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2A966C),
              ),
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
