import 'package:flutter/material.dart';

import '../../../services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Add form key for validation

  String error = '';
  bool _obscureText = true;

  bool isValidEmail(String email) {
    // Simple regex for email validation
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back !",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                              color: Color(0xFF101018)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                            "Happy to see you again! Please enter your email \n and password to login to your account.",
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
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left: 18.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 220, 220, 220),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 4),
                              Icon(
                                Icons.email,
                                color: Color.fromARGB(255, 159, 159, 159),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
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
                        SizedBox(height: 18.0),

                        Container(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color.fromARGB(255, 220, 220, 220),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 8.0),
                              Icon(
                                Icons.lock,
                                color: Color.fromARGB(255, 159, 159, 159),
                              ),
                              SizedBox(width: 12.0),
                              Expanded(
                                child: TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: InputBorder.none,
                                  ),
                                  obscureText: _obscureText,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
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
                                  color: Color.fromARGB(255, 159, 159, 159),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 40.0),
                        SizedBox(
                          width: double.infinity,
                          height: 52.0,
                          child: ElevatedButton(
                            child: Text('Sign In',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500)),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                final String email =
                                    _emailController.text.trim();
                                final String password =
                                    _passwordController.text.trim();
                                try {
                                  dynamic result =
                                      await _auth.signInWithEmailAndPassword(
                                          email, password, context);
                                  if (result == null) {
                                    setState(() {
                                      error =
                                          'Could not sign in with those credentials';
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
                              backgroundColor: Color(0xFF2A966C),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(48.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 18.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 1.0,
                                width: 120,
                                color: Color.fromARGB(255, 220, 220, 220),
                              ),
                              Text("or",
                                  style: TextStyle(
                                      color: Color(0xFF828F9C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins')),
                              Container(
                                height: 1.0,
                                width: 120.0,
                                color: Color.fromARGB(255, 220, 220, 220),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 18.0),

                        SizedBox(
                          width: double.infinity,
                          height: 52.0,
                          child: ElevatedButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/varun/google_logo.png',
                                  height: 24.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text("Login with Google",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                            onPressed: () async {
                              _auth.signInWithGoogle(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(48.0),
                                side: BorderSide(
                                  color: Color.fromARGB(255, 220, 220, 220),
                                  width: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            widget.toggleView(); // Navigate to Sign Up screen
                          },
                          child: Text(
                            "Don't have an account ? ",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ), // Add some space
                      ],
                    ),
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
