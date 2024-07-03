// profile_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            margin: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Username'),
              subtitle: Text(user?.email ?? 'No email'),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16.0),
            child: ListTile(
              leading: const Icon(Icons.lock),
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _reAuthenticateAndChangePassword(context),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(16.0),
            child: ListTile(
                leading: const Icon(Icons.lock),
                title: const Text('Logout'),
                trailing: const Icon(Icons.logout),
                onTap: () {
                  signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WelcomeScreen(),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

void signOut() {
  FirebaseAuth.instance.signOut();
}
