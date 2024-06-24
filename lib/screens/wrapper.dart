import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication/authenticate.dart';
import 'authentication/register.dart';
import 'authentication/signin.dart';
import 'users/user_main.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    if (user == null) {
      return Authenticate();
    } else {
      return FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
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
            // user
            case 'user':
              return UserPage();

            default:
              return Scaffold(body: Center(child: Text('Unknown user role')));
          }
        },
      );
    }
  }
}
