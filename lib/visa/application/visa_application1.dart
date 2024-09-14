import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For Date Formatting
import 'visa_application2.dart'; // Import the Upload Document page

class VisaApplicationFormPage extends StatefulWidget {
  const VisaApplicationFormPage({super.key});

  @override
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
      // Navigate to the document upload page and pass the form data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => UploadDocumentPage(
            firstName: _FirstNameContoller.text,
            surname: _SurnameController.text,
            dob: _dobController.text,
            nationality: _nationality!,
            passportNumber: _PassportContoller.text,
            passportIssueDate: _issueDateController.text,
            passportExpiryDate: _expiryDateController.text,
            durationOfStay: _durationOfStay!,
          ),
        ),
      );
    }
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
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _FirstNameContoller,
                        decoration: const InputDecoration(
                          labelText: 'First Name',
                          border: OutlineInputBorder(),
                        ),
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
                        decoration: const InputDecoration(
                          labelText: 'Surname',
                          border: OutlineInputBorder(),
                        ),
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
                        decoration: const InputDecoration(
                          labelText: 'Date of Birth',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
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
                        decoration: const InputDecoration(
                          labelText: 'Nationality',
                          border: OutlineInputBorder(),
                        ),
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
                        decoration: const InputDecoration(
                          labelText: 'Passport Number',
                          border: OutlineInputBorder(),
                        ),
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
                        decoration: const InputDecoration(
                          labelText: 'Passport Issue Date',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today),
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
                  decoration: const InputDecoration(
                    labelText: 'Passport Expiry Date',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(Icons.calendar_today),
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
                  decoration: const InputDecoration(
                    labelText: 'Duration of Stay',
                    border: OutlineInputBorder(),
                  ),
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
                const SizedBox(height: 32),

                // Continue Button
                Center(
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      backgroundColor: const Color(0xFF00BA72),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Continue'),
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
