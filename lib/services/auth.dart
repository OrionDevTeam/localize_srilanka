import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../screens/users/guideUsermain.dart';
import '../screens/users/user_main.dart';
import '../screens/admin/adminPage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Create a user object based on FirebaseUser
  User? _userFromFirebaseUser(User? user) {
    return user;
  }

  // Auth change user stream
  Stream<User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in with email and password
  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        await _checkEmailVerification(user, context);
      }

      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error in signInWithEmailAndPassword: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign in failed: $e')));
      return null;
    }
  }

  // Register with email and password
  Future<User?> registerWithEmailAndPassword(String username, String email,
      String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        // Send email verification
        await user.sendEmailVerification();

        // Create a new document for the user with the uid
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'user_role': 'user', // Set default role as 'customer'
        });

        // Show verification message
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Verification email has been sent. Please verify your email.'),
        ));
      }

      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error in registerWithEmailAndPassword: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration failed: $e')));
      return null;
    }
  }

  // Register with email and password -- Admin creation
  Future<bool> registerAdminWithEmailAndPassword(String username, String email,
      String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      final user = result.user;
      if (user != null) {
        // Create a new document for the user with the uid
        await _firestore.collection('users').doc(user.uid).set({
          'username': username,
          'email': email,
          'user_role': 'admin', // Set default role as 'customer'
        });
      }

      return true;
    } catch (e) {
      print('Error in registerWithEmailAndPassword: $e');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration failed: $e')));
      return false;
    }
  }

  // Check if email is verified
  Future<void> _checkEmailVerification(User user, BuildContext context) async {
    user = _auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      // Email verified, navigate to appropriate page
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();
      String role = userDoc.exists ? userDoc['user_role'] : 'customer';
      _navigateBasedOnRole(context, role);
    } else {
      // Email not verified, show resend option
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Email not verified. Please check your email for verification link or resend verification email.'),
      ));
    }
  }

  // Resend email verification
  Future<void> resendVerificationEmail(BuildContext context) async {
    User? user = _auth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Verification email resent. Please check your email.'),
      ));
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print('Error in signOut: $e');
    }
  }

  // Sign in with Google
  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential result = await _auth.signInWithCredential(credential);
      User? user = result.user;

      if (user != null) {
        await _checkEmailVerification(user, context);
      }

      return _userFromFirebaseUser(user);
    } catch (e) {
      print('Error in signInWithGoogle: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign in with Google failed: $e')));
      return null;
    }
  }

  // Helper method to navigate based on user role
  void _navigateBasedOnRole(BuildContext context, String role) {
    switch (role) {
      case 'user':
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const UserPage()));
        break;
      case 'Guide':
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const GuidePage()));
        break;
      case 'admin':
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const AdminPage()));
        break;
      default:
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signed in as normal user')));
    }
  }
}
