import 'package:flutter/material.dart';

import '../../../services/auth.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({super.key, required this.toggleView});

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
                  const SizedBox(
                    height: 80,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
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
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                              "Happy to see you again! Please enter your email and password to login to your account.",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  fontFamily: 'Poppins',
                                  color: Color(
                                      0xFF828F9C) // Make sure the font family name is a string
                                  )),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
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
                        const SizedBox(height: 18.0),

                        Container(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromARGB(255, 220, 220, 220),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(48.0),
                          ),
                          child: Row(
                            children: [
                              const SizedBox(width: 8.0),
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
                                  color:
                                      const Color.fromARGB(255, 159, 159, 159),
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

                        const SizedBox(height: 40.0),
                        SizedBox(
                          width: double.infinity,
                          height: 52.0,
                          child: ElevatedButton(
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
                              backgroundColor: const Color(0xFF2A966C),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(48.0),
                              ),
                            ),
                            child: const Text('Sign In',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                        const SizedBox(height: 18.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 1.0,
                                width: 120,
                                color: const Color.fromARGB(255, 220, 220, 220),
                              ),
                              const Text("or",
                                  style: TextStyle(
                                      color: Color(0xFF828F9C),
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins')),
                              Container(
                                height: 1.0,
                                width: 120.0,
                                color: const Color.fromARGB(255, 220, 220, 220),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18.0),

                        SizedBox(
                          width: double.infinity,
                          height: 52.0,
                          child: ElevatedButton(
                            onPressed: () async {
                              _auth.signInWithGoogle(context);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              shadowColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(48.0),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 220, 220, 220),
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/varun/google_logo.png',
                                  height: 24.0,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                const Text("Login with Google",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () {
                            widget.toggleView(); // Navigate to Sign Up screen
                          },
                          child: const Text(
                            "Don't have an account ? ",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          error,
                          style: const TextStyle(
                              color: Colors.red, fontSize: 14.0),
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
