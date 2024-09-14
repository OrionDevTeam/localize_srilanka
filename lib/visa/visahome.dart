import 'package:flutter/material.dart';
import 'applications.dart';
import 'applyforvisa.dart';
import 'checklist.dart';
import 'cont.dart';
import 'eligibiltychecker.dart';
import 'progress.dart';
import 'visacard.dart';

class VisaHomePage extends StatelessWidget {
  const VisaHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('Get your Travel Visa \n Within a day!',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w500)),
                ),
              ],
            ),
            SingleChildScrollView(
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ApplyForVisaPage(
                                  color: Color(0xFF2A966C),
                                  cost: "30\$",
                                  imagePath: 'assets/visa/girl.png',
                                )),
                      );
                    },
                    backgroundColor:
                        const Color(0xFF2A966C), // Custom background color
                    buttonColor: const Color(0xFF2A966C), // Custom button color
                  ),
                  const SizedBox(width: 10),
                  VisaCard(
                    backgroundImagePath: 'assets/visa/sl.png',
                    foregroundImagePath: 'assets/visa/g2.png',
                    visaType: "Tourist visa with",
                    duration: "Single Entry for 60 days",
                    features: const [
                      "Simple Process",
                      "Quick Review",
                      "Faster Approval"
                    ],
                    onApply: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ApplyForVisaPage(
                                  color: Color.fromARGB(255, 29, 168, 232),
                                  cost: "150\$",
                                  imagePath: 'assets/visa/g2.png',
                                )),
                      );
                    },
                    backgroundColor: const Color.fromARGB(255, 29, 168, 232),
                    buttonColor: const Color.fromARGB(255, 29, 168, 232),
                  ),
                  const SizedBox(width: 10),
                  VisaCard(
                    backgroundImagePath: 'assets/visa/sl.png',
                    foregroundImagePath: 'assets/visa/g1.png',
                    visaType: "Tourist visa with",
                    duration: "Single Entry for 28 days",
                    features: const [
                      "Simple Process",
                      "Quick Review",
                      "Faster Approval"
                    ],
                    onApply: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ApplyForVisaPage(
                                  color:
                                      Color.fromARGB(255, 222, 170, 38),
                                  cost: "50\$",
                                  imagePath: 'assets/visa/g1.png',
                                )),
                      );
                    },
                    backgroundColor: const Color.fromARGB(255, 222, 170, 38),
                    buttonColor: const Color.fromARGB(255, 222, 170, 38),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // check progress
            ClickableContainer(
              icon: Icons.assignment_turned_in,
              title: 'Check your progress',
              subtitle: 'Track the progress of your visa application',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ApplicationsScreen()),
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
                  MaterialPageRoute(
                      builder: (context) => const VisaApplicationScreen1()),
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
                      builder: (context) => const VisaDocumentsChecklist()),
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
                  MaterialPageRoute(builder: (context) => const EligibilityChecker()),
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
                  MaterialPageRoute(builder: (context) => const LearnMorePage()),
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
  const ProgressCheckPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Progress Check')),
      body: const Center(child: Text('Progress Check Page')),
    );
  }
}

class LearnMorePage extends StatelessWidget {
  const LearnMorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Learn more')),
      body: const Center(child: Text('Learn More Page')),
    );
  }
}

class EligibilityCheckerPage extends StatelessWidget {
  const EligibilityCheckerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Eligibility Checker')),
      body: const Center(child: Text('Eligibility Checker Page')),
    );
  }
}

class DocumentChecklistPage extends StatelessWidget {
  const DocumentChecklistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Document Checklist')),
      body: const Center(child: Text('Document Checklist Page')),
    );
  }
}
