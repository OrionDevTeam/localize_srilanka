import 'package:flutter/material.dart';

import '../../../services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({super.key, required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String error = '';
  bool _obscureText = true;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool isValidUsername(String username) {
    return RegExp(r'^[a-zA-Z0-9]{3,16}$').hasMatch(username);
  }

  bool isValidPassword(String password) {
    return password.length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(password) &&
        RegExp(r'[a-z]').hasMatch(password) &&
        RegExp(r'[0-9]').hasMatch(password) &&
        RegExp(r'[!@#\$&*~]').hasMatch(password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Form(
            key: _formKey,
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Sign up",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Color(0xFF101018)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "Welcome! Please enter your Name, email and\n password to create your account.",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Color(
                                    0xFF828F9C) // Make sure the font family name is a string
                                )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 18.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 220, 220),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(48.0),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.person,
                          color: Color.fromARGB(255, 159, 159, 159),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              border: InputBorder.none,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter a username';
                              } else if (!isValidUsername(value)) {
                                return 'Please enter a valid username';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    padding: const EdgeInsets.only(left: 18.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 220, 220),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(48.0),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.email,
                          color: Color.fromARGB(255, 159, 159, 159),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              border: InputBorder.none,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address';
                              } else if (!isValidEmail(value)) {
                                return 'Please enter a valid email address';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    padding: const EdgeInsets.only(left: 18.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 220, 220),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(48.0),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 159, 159, 159),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              border: InputBorder.none,
                            ),
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (!isValidPassword(value)) {
                                return 'Password must be at least 8 characters long, include an uppercase letter, a lowercase letter, a number, and a special character';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color.fromARGB(255, 159, 159, 159),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        const SizedBox(width: 12.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Container(
                    padding: const EdgeInsets.only(left: 18.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 220, 220),
                          width: 1.0),
                      borderRadius: BorderRadius.circular(48.0),
                    ),
                    child: Row(
                      children: [
                        const SizedBox(width: 4.0),
                        const Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 159, 159, 159),
                        ),
                        const SizedBox(width: 12.0),
                        Expanded(
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              border: InputBorder.none,
                            ),
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: const Color.fromARGB(255, 159, 159, 159),
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        const SizedBox(width: 12.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final String username =
                              _usernameController.text.trim();
                          final String email = _emailController.text.trim();
                          final String password =
                              _passwordController.text.trim();
                          try {
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    username, email, password, context);
                            if (result == null) {
                              setState(() {
                                error =
                                    'Could not register with those credentials';
                              });
                            }
                          } catch (e) {
                            setState(() {
                              error = 'An error occurred: $e';
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2A966C),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(48.0),
                        ),
                      ),
                      child: const Text('Create new account',
                          style: TextStyle(fontSize: 16.0)),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {
                      widget.toggleView();
                    },
                    child: const Text(
                      "Already have an account? Sign In",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
