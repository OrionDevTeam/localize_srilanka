import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localize_sl/screens/getStarted.dart';
import 'package:localize_sl/screens/users/guideUsermain.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'admin/adminPage.dart';
import 'authentication/register.dart';
import 'authentication/signin.dart';
import 'users/user_main.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return WelcomeScreen();
    } else {
      return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(
                    child: CircularProgressIndicator(color: Colors.green)));
          }

          if (snapshot.hasError) {
            return Scaffold(
                body: Center(child: Text('Error: ${snapshot.error}')));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return SignIn(
              toggleView: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Register(toggleView: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignIn(toggleView: () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Register(toggleView: () {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              SignIn(
                                                                  toggleView:
                                                                      () {})),
                                                    );
                                                  })),
                                        );
                                      })),
                            );
                          })),
                );
              },
            );
          }

          String role = snapshot.data!['user_role'];

          switch (role) {
            case 'user':
              return UserPage();
            // admin
            case 'admin':
              return AdminPage();
            case 'Guide':
              return const GuidePage();
            default:
              return const Scaffold(
                  body: Center(child: Text('Unknown user role')));
          }
        },
      );
    }
  }
}
