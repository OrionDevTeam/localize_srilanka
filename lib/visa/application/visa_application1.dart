import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For Date Formatting
import 'package:localize_sl/visa/application/visa_application2.dart';

class VisaApplicationFormPage extends StatefulWidget {
  final DocumentSnapshot visa;
  const VisaApplicationFormPage({Key? key, required this.visa}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _VisaApplicationFormPageState createState() =>
      _VisaApplicationFormPageState();
}

class _VisaApplicationFormPageState extends State<VisaApplicationFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _FirstNameContoller = TextEditingController();
  final TextEditingController _SurnameController = TextEditingController();
  final TextEditingController _PassportContoller = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _issueDateController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  String? _durationOfStay = '30 Days';
  String? _nationality = 'Indian';

  @override
  void initState() {
    super.initState();
    // Pre-fill the form with existing values from the visa document
    if (widget.visa.exists) {
      final data = widget.visa.data() as Map<String, dynamic>;

      _FirstNameContoller.text = data['firstName'] ?? '';
      _SurnameController.text = data['surname'] ?? '';
      _dobController.text = data['dob'] ?? '';
      _PassportContoller.text = data['passportNumber'] ?? '';
      _issueDateController.text = data['passportIssueDate'] ?? '';
      _expiryDateController.text = data['passportExpiryDate'] ?? '';
      _durationOfStay = data['durationOfStay'] ?? '30 Days';
      _nationality = data['nationality'] ?? 'Indian';
    }
  }

  // Function to pick a date
  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd MMM yyyy').format(picked);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Create or update Firestore document with the form values
      widget.visa.reference.set({
        'firstName': _FirstNameContoller.text,
        'surname': _SurnameController.text,
        'dob': _dobController.text,
        'passportNumber': _PassportContoller.text,
        'passportIssueDate': _issueDateController.text,
        'passportExpiryDate': _expiryDateController.text,
        'durationOfStay': _durationOfStay!,
        'nationality': _nationality!,
      }, SetOptions(merge: true)).then((_) {
        // Navigate to the document upload page and pass the form data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadDocumentPage(
              visa: widget.visa,
            ),
          ),
        );
      }).catchError((error) {
        // Handle any errors that occur during the update
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update document: $error')),
        );
      });
    }
  }

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(
          color: Color(0xFF2A966C)), // Label color when not focused
      fillColor: const Color(0xFFF5F5F5), // Background fill color
      filled: true, // Enable fill color
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF2A966C), // Border color when not focused
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF2A966C), // Border color when not focused
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(
          color: Color(0xFF2A966C), // Border color when focused
          width: 2.0,
        ),
      ),
      hoverColor:
          Colors.greenAccent, // Optional hover effect for web/desktop platforms
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Center(
                  child: Text(
                    'Personal Information',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Add an image
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                      child: Image(
                    image: AssetImage('assets/visa/1.png'),
                  )),
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _FirstNameContoller,
                        decoration: _inputDecoration('First Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _SurnameController,
                        decoration: _inputDecoration('Surname'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your surname';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dobController,
                        decoration: _inputDecoration('Date of Birth').copyWith(
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, _dobController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your date of birth';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _nationality,
                        decoration: _inputDecoration('Nationality'),
                        items: [
                          'Indian',
                          'American',
                          'British',
                          'Chinese',
                          'African'
                        ]
                            .map((String nationality) =>
                                DropdownMenuItem<String>(
                                  value: nationality,
                                  child: Text(nationality),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _nationality = newValue;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _PassportContoller,
                        decoration: _inputDecoration('Passport Number'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your passport number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _issueDateController,
                        decoration:
                            _inputDecoration('Passport Issue Date').copyWith(
                          suffixIcon: const Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () => _selectDate(context, _issueDateController),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter passport issue date';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _expiryDateController,
                  decoration: _inputDecoration('Passport Expiry Date').copyWith(
                    suffixIcon: const Icon(Icons.calendar_today),
                  ),
                  readOnly: true,
                  onTap: () => _selectDate(context, _expiryDateController),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter passport expiry date';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _durationOfStay,
                  decoration: _inputDecoration('Duration of Stay'),
                  items: ['30 Days', '60 Days', '90 Days']
                      .map((String duration) => DropdownMenuItem<String>(
                            value: duration,
                            child: Text(duration),
                          ))
                      .toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _durationOfStay = newValue;
                    });
                  },
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      backgroundColor: const Color(0xFF2A966C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Submit and Continue',
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
