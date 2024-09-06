import 'package:flutter/material.dart';

class VisaApplicationScreen extends StatefulWidget {
  @override
  _VisaApplicationScreenState createState() => _VisaApplicationScreenState();
}

class _VisaApplicationScreenState extends State<VisaApplicationScreen> {
  int _currentStep = 0;
  bool _complete = false;

  List<Step> getSteps() => [
        Step(
          title: Text('Select Visa Type'),
          content: Text(
              'Check whether you require a visa and apply for the correct visa.'),
          isActive: _currentStep >= 0,
          state: _currentStep > 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Fill the Form'),
          content: _buildForm(),
          isActive: _currentStep >= 1,
          state: _currentStep > 1 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Upload Documents'),
          content: Text('Upload necessary documents.'),
          isActive: _currentStep >= 2,
          state: _currentStep > 2 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Payment'),
          content: Text('Complete payment for the visa application.'),
          isActive: _currentStep >= 3,
          state: _currentStep > 3 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Submit for Review'),
          content: Text('Submit the application for review.'),
          isActive: _currentStep >= 4,
          state: _currentStep > 4 ? StepState.complete : StepState.indexed,
        ),
        Step(
          title: Text('Completed'),
          content: Text('Your visa application is completed.'),
          isActive: _currentStep >= 5,
          state: StepState.complete,
        ),
      ];

  Widget _buildForm() {
    return Column(
      children: <Widget>[
        TextFormField(
          decoration: InputDecoration(labelText: 'Full Name'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Passport Number'),
        ),
        TextFormField(
          decoration: InputDecoration(labelText: 'Date of Birth'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Visa Application'),
      ),
      body: _complete
          ? Center(child: Text('Application Completed!'))
          : Stepper(
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
    );
  }
}
