import 'package:flutter/material.dart';
import 'visacard.dart';
import 'applyforvisa.dart';
import 'checklist.dart';
import 'cont.dart';
import 'eligibiltychecker.dart';
import 'progress.dart';
import 'applications.dart';

class VisaHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(left:32.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 1), // Add some space between the back button and the text
              Expanded(
                child: Text(
                  'Get your Travel Visa here!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enable horizontal scrolling
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Add some padding to space out the cards
                    const SizedBox(width: 20),
                    VisaCard(
                      backgroundImagePath: 'assets/visa/sl.png',
                      foregroundImagePath: 'assets/visa/girl.png',
                      visaType: "Tourist visa with",
                      duration: "Single Entry for 14 days",
                      features: const [
                        "Simple Process",
                        "Quick Review",
                        "Faster Approval"
                      ],
                      onApply: () {
                        print("Apply Now button clicked!");
                      },
                      backgroundColor:
                          const Color(0xFF2A966C), // Custom background color
                      buttonColor:
                          const Color(0xFF2A966C), // Custom button color
                    ),
                    const SizedBox(width: 10),
                    VisaCard(
                      backgroundImagePath: 'assets/visa/sl.png',
                      foregroundImagePath: 'assets/visa/girl.png',
                      visaType: "Tourist visa with",
                      duration: "Single Entry for 28 days",
                      features: const [
                        "Simple Process",
                        "Quick Review",
                        "Faster Approval"
                      ],
                      onApply: () {
                        print("Apply Now button clicked!");
                      },
                      backgroundColor: const Color.fromARGB(255, 222, 170, 38),
                      buttonColor: const Color.fromARGB(255, 222, 170, 38),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            // check progress
            ClickableContainer(
              icon: Icons.assignment_turned_in,
              title: 'Check your progress',
              subtitle: 'Track the progress of your visa applications',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ApplicationsScreen()),
                );
              },
            ),
            ClickableContainer(
              icon: Icons.assignment,
              iconColor: Colors.blue[700],
              title: 'Apply for Visa',
              subtitle: 'Apply for a visa to your desired destination',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ApplyForVisaPage()),
                );
              },
            ),
            ClickableContainer(
              icon: Icons.checklist,
              iconColor: Colors.green[700],
              title: 'Document Checklist',
              subtitle: 'Check the required documents for your visa',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VisaDocumentsChecklist()),
                );
              },
            ),
            ClickableContainer(
              icon: Icons.search,
              iconColor: Colors.orange[700],
              title: 'Eligibility Checker',
              subtitle: 'Check your eligibility for a visa',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EligibilityChecker()),
                );
              },
            ),
            ClickableContainer(
              icon: Icons.info,
              iconColor: Colors.purple[700],
              title: 'Learn More',
              subtitle: 'Learn more about visa policies and regulations',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LearnMorePage()),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class ProgressCheckPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress Check')),
      body: const Center(child: Text('Progress Check Page')),
    );
  }
}

class LearnMorePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn more')),
      body: const Center(child: Text('Learn More Page')),
    );
  }
}

class EligibilityCheckerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eligibility Checker')),
      body: const Center(child: Text('Eligibility Checker Page')),
    );
  }
}

class DocumentChecklistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Checklist')),
      body: const Center(child: Text('Document Checklist Page')),
    );
  }
}
