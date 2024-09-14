import 'package:flutter/material.dart';

class VisaProgressBar extends StatefulWidget {
  const VisaProgressBar({super.key});

  @override
  _VisaProgressBarState createState() => _VisaProgressBarState();
}

class _VisaProgressBarState extends State<VisaProgressBar> {
  double _progressValue = 0.6; // Default progress value (60%)

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Progress bar with checkmarks
          Stack(
            children: [
              Container(
                height: 25,
                decoration: BoxDecoration(
                  color:
                      Colors.grey[300], // Background color of the progress bar
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              FractionallySizedBox(
                widthFactor: _progressValue, // Adjust the progress dynamically
                child: Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.green, // Progress bar fill color
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              // White Checkmarks for each stage (20%, 40%, 60%, 80%, 100%)
              Positioned(
                left: MediaQuery.of(context).size.width * 0,
                child: const Icon(Icons.check_circle, color: Colors.white, size: 25),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.12,
                child: const Icon(Icons.check_circle, color: Colors.white, size: 25),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.30,
                child: const Icon(Icons.check_circle, color: Colors.white, size: 25),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.48,
                child: const Icon(Icons.check_circle, color: Colors.white, size: 25),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.73,
                child: const Icon(Icons.check_circle, color: Colors.white, size: 25),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Display progress level
          Text(
            'Level: ${(_progressValue * 100).round()}%', // Progress value as a percentage
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Slider to manually adjust the progress
          Slider(
            value: _progressValue,
            min: 0.0,
            max: 1.0,
            divisions:
                5, // Divides the slider into 5 steps (20%, 40%, 60%, 80%, 100%)
            label:
                '${(_progressValue * 100).round()}%', // Display the current value on the slider
            onChanged: (value) {
              setState(() {
                _progressValue =
                    value; // Update the progress when slider is moved
              });
            },
          ),
        ],
      ),
    );
  }
}
