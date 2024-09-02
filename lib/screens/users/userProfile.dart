import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
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
              title: const Text('Account Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserSettingsPage()),
                );
              },
            ),
          ),
          ClickableContainer(
            icon: Iconsax.notification,
            iconColor: Colors.blue[700],
            title: 'Noticication Settings',
            subtitle: 'Customize your notification settings',
            onTap: () {
              print('Wireless & Network tapped');
            },
          ),
          DoubleClickableContainer(
            icon1: Iconsax.cards,
            icon2: Icons.language,
            iconColor1: Colors.pink[700],
            iconColor2: Colors.green[700],
            title1: 'Payment Methods',
            title2: 'Language Settings',
            subtitle1: 'Manage your payment methods',
            subtitle2: 'Change the app language',
            onTap1: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WalletPage()),
              );
            },
            onTap2: () {
              signOut();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WelcomeScreen()),
              );
            },
          ),
          Card(
            margin: const EdgeInsets.all(8.0), // Reduced margin
            child: ListTile(
              leading: const Icon(Icons.notifications_active_outlined),
              title: const Text('Notification Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => _reAuthenticateAndChangePassword(context),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0), // Reduced margin
            child: ListTile(
              leading: const Icon(Icons.payment_rounded),
              title: const Text('Payment Methods'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletPage()),
                );
              },
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0), // Reduced margin
            child: ListTile(
              leading: const Icon(Icons.language),
              title: const Text('Language Settings'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()),
                );
              },
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

class ClickableContainer extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ClickableContainer({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Row(
              children: [
                // Leading Icon
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: iconColor?.withOpacity(0.3) ??
                        Colors.blue.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? Colors.blue[700],
                  ),
                ),
                SizedBox(width: 16),
                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DoubleClickableContainer extends StatelessWidget {
  final IconData icon1, icon2;
  final Color? iconColor1, iconColor2;
  final String title1, title2;
  final String subtitle2, subtitle1;
  final VoidCallback onTap1, onTap2;

  const DoubleClickableContainer({
    Key? key,
    required this.icon1,
    required this.icon2,
    required this.title1,
    required this.title2,
    required this.subtitle1,
    required this.subtitle2,
    required this.onTap1,
    required this.onTap2,
    this.iconColor1,
    this.iconColor2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 10,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap1,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                child: Row(
                  children: [
                    // Leading Icon
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: iconColor1?.withOpacity(0.3) ??
                            Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon1,
                        color: iconColor1 ?? Colors.blue[700],
                      ),
                    ),
                    SizedBox(width: 16),
                    // Title and Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title1,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            subtitle1,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          // add a divider
          Divider(),
          SizedBox(height: 8),

          GestureDetector(
            onTap: onTap2,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                child: Row(
                  children: [
                    // Leading Icon
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: iconColor2?.withOpacity(0.3) ??
                            Colors.blue.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        icon2,
                        color: iconColor2 ?? Colors.blue[700],
                      ),
                    ),
                    SizedBox(width: 16),
                    // Title and Subtitle
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title2,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            subtitle2,
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
