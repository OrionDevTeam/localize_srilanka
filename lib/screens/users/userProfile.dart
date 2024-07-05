import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:localize_sl/screens/users/user_help.dart';
import 'package:localize_sl/screens/users/user_settings.dart';
import 'package:localize_sl/screens/users/user_wallet.dart';

import '../../get_started.dart';
import '../getStarted.dart';

class userProfilePage extends StatelessWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  userProfilePage({super.key});

  void _reAuthenticateAndChangePassword(BuildContext context) async {
    TextEditingController currentPasswordController = TextEditingController();
    TextEditingController newPasswordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Center(
              child: Text(
            'Change Password',
            style: TextStyle(fontSize: 18),
          )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: currentPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: () async {
                if (newPasswordController.text ==
                    confirmPasswordController.text) {
                  try {
                    // Re-authenticate the user
                    AuthCredential credential = EmailAuthProvider.credential(
                      email: user!.email!,
                      password: currentPasswordController.text,
                    );
                    await user!.reauthenticateWithCredential(credential);

                    // Change the password
                    await user!.updatePassword(newPasswordController.text);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Password changed successfully!'),
                    ));
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Error: $e'),
                    ));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Passwords do not match'),
                  ));
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: const Text(
                  'Change Password',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: const EdgeInsets.all(8.0), // Reduced margin
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text(
                'Account Settings',
                style: TextStyle(fontSize: 20),
              ),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserSettingsPage()),
                );
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0), // Reduced margin
            child: ListTile(
              leading: const Icon(Icons.notifications_active_outlined),
              title: const Text('Notification Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              // onTap: () => _reAuthenticateAndChangePassword(context),
            ),
          ),
          // Card(
          //   margin: const EdgeInsets.all(8.0), // Reduced margin
          //   child: ListTile(
          //     leading: const Icon(Icons.payment_rounded),
          //     title: const Text('Payment Methods'),
          //     trailing: const Icon(Icons.arrow_forward_ios),
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(builder: (context) => WalletPage()),
          //       );
          //     },
          //   ),
          // ),
          Card(
            margin: const EdgeInsets.all(8.0), // Reduced margin
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              // onTap: () {
              //   signOut();
              //   Navigator.push(
              //     context,
              //     MaterialPageRoute(builder: (context) => WelcomeScreen()),
              //   );
              // },
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0), // Reduced margin
            child: ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Face ID & Passcode'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0), // Reduced margin
            child: ListTile(
              leading: const Icon(Icons.chat_outlined),
              title: const Text('Help'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NeedHelpPage()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void signOut() {
  FirebaseAuth.instance.signOut();
}
