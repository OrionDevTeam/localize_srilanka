import 'package:flutter/material.dart';

class EligibilityChecker extends StatefulWidget {
  @override
  _EligibilityCheckerState createState() => _EligibilityCheckerState();
}

class _EligibilityCheckerState extends State<EligibilityChecker> {
  final _formKey = GlobalKey<FormState>();

  // Variables to hold input values
  int age = 0;
  String citizenship = '';
  String employmentStatus = '';
  double income = 0.0;
  String educationLevel = '';
  String maritalStatus = '';
  int dependents = 0;
  bool hasValidPassport = false;
  bool hasCriminalRecord = false;
  String eligibilityMessage = '';

  // List of available options
  final List<String> citizenshipOptions = [
    'Select',
    'Country A',
    'Country B',
    'Country C'
  ];

  final List<String> employmentOptions = [
    'Select',
    'Employed',
    'Self-employed',
    'Unemployed',
    'Student'
  ];

  final List<String> educationOptions = [
    'Select',
    'High School',
    'Bachelor’s Degree',
    'Master’s Degree',
    'PhD'
  ];

  final List<String> maritalStatusOptions = [
    'Select',
    'Single',
    'Married',
    'Divorced',
    'Widowed'
  ];

  // Eligibility logic
  void checkEligibility() {
    if (age >= 18 &&
        (citizenship == 'Country A' || citizenship == 'Country B') &&
        employmentStatus != 'Unemployed' &&
        income > 10000 &&
        educationLevel != 'Select' &&
        maritalStatus != 'Select' &&
        hasValidPassport &&
        !hasCriminalRecord) {
      setState(() {
        eligibilityMessage = 'You are eligible for the visa.';
      });
    } else {
      setState(() {
        eligibilityMessage = 'You are not eligible for the visa.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Eligibility Checker'),
        backgroundColor: Colors.white, // Custom color for app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                // Age Input
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter your age',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2A966C)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age';
                    }
                    age = int.parse(value);
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Citizenship Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select your citizenship',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2A966C)),
                    ),
                  ),
                  value: citizenshipOptions.first,
                  items: citizenshipOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      citizenship = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == 'Select') {
                      return 'Please select your citizenship';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Employment Status Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select your employment status',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2A966C)),
                    ),
                  ),
                  value: employmentOptions.first,
                  items: employmentOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      employmentStatus = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == 'Select') {
                      return 'Please select your employment status';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Income Input
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter your annual income',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2A966C)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your income';
                    }
                    income = double.parse(value);
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Education Level Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select your education level',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2A966C)),
                    ),
                  ),
                  value: educationOptions.first,
                  items: educationOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      educationLevel = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == 'Select') {
                      return 'Please select your education level';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Marital Status Dropdown
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Select your marital status',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2A966C)),
                    ),
                  ),
                  value: maritalStatusOptions.first,
                  items: maritalStatusOptions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      maritalStatus = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value == 'Select') {
                      return 'Please select your marital status';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Number of Dependents Input
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter the number of dependents',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF2A966C)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the number of dependents';
                    }
                    dependents = int.parse(value);
                    return null;
                  },
                ),
                SizedBox(height: 20),

                // Valid Passport Checkbox
                CheckboxListTile(
                  title: Text("Do you have a valid passport?"),
                  value: hasValidPassport,
                  onChanged: (bool? value) {
                    setState(() {
                      hasValidPassport = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Color(0xFF2A966C), // Custom checked color
                ),

                // Criminal Record Checkbox
                CheckboxListTile(
                  title: Text("Do you have any criminal record?"),
                  value: hasCriminalRecord,
                  onChanged: (bool? value) {
                    setState(() {
                      hasCriminalRecord = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  activeColor: Color(0xFF2A966C), // Custom checked color
                ),
                SizedBox(height: 20),

                // Check Eligibility Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        checkEligibility();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2A966C),
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            12), // Set the border radius here
                      ),
                    ),
                    child: Text(
                      "Check Eligibility",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                Center(
                  child: Text(
                    eligibilityMessage,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color:
                          eligibilityMessage == 'You are eligible for the visa.'
                              ? Colors.green
                              : Colors.red,
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
