import 'package:flutter/material.dart';
import 'application/visa_application_home.dart';

class VisaApplicationScreen1 extends StatefulWidget {
  const VisaApplicationScreen1({super.key});

  @override
  _VisaApplicationScreenState createState() => _VisaApplicationScreenState();
}

class _VisaApplicationScreenState extends State<VisaApplicationScreen1> {
  int _currentStep = 0;
  bool _complete = false;

  List<Step> getSteps() => [
        Step(
          title: const Text('Select Visa Type'),
          content: const Text(
              'Check whether you require a visa and apply for the correct visa.'),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: const Text('Fill the Form'),
          content: _buildForm(),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: const Text('Upload Documents'),
          content: _buildForm2(),
          isActive: _currentStep >= 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: const Text('Payment'),
          content: const Text('Complete payment for the visa application.'),
          isActive: _currentStep >= 3,
          state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: const Text('Submit for Review'),
          content: const Text('Submit the application for review.'),
          isActive: _currentStep >= 4,
          state: _currentStep > 4 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: const Text('Completed'),
          content: const Text('Your visa application is completed.'),
          isActive: _currentStep >= 5,
          state: StepState.complete,
        ),
      ];

  Widget _buildForm() {
    return const Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You have to fill the following details:\n'),
            Text('• First Name'),
            Text('• Surname'),
            Text('• Date of Birth'),
            Text('• Nationality'),
            Text('• Passport Number'),
            Text('• Passport Issue Date'),
            Text('• Passport Expiry Date'),
          ],
        ),
      ],
    );
  }

  Widget _buildForm2() {
    return const Column(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You have to upload the following documents:\n'),
            Text('• NIC copy'),
            Text('• Passport copy'),
            Text('• Your photo'),
            Text('• Bank statement'),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Visa Application'),
      ),
      body: _complete
          ? const SelectVisaType()
          : Theme(
              data: ThemeData(
                primaryColor: const Color(0xFF2A966C), // Set primary color
                hintColor: const Color(0xFF2A966C), // Set accent color
                colorScheme: const ColorScheme.light(
                    primary: Color(
                        0xFF2A966C)), // Set color scheme for stepper indicators
              ),
              child: Stepper(
                currentStep: _currentStep,
                onStepTapped: (step) => setState(() => _currentStep = step),
                onStepContinue: _currentStep < getSteps().length - 1
                    ? () => setState(() => _currentStep += 1)
                    : () => setState(() => _complete = true),
                onStepCancel: _currentStep > 0
                    ? () => setState(() => _currentStep -= 1)
                    : null,
                steps: getSteps(),
              ),
            ),
    );
  }
}
