import 'package:flutter/material.dart';
import 'package:localize_sl/colorpalate.dart';

class PackageOptionsScreen extends StatelessWidget {
  const PackageOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.grey[100], // Background color similar to the design
      appBar: AppBar(
        title: const Text("Package options"),
        backgroundColor: Colors.teal, // Customize the AppBar color
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0), // Padding around the content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Package Type section
            Text(
              'Package type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            // hi hello
            Row(
              children: [
                // Data in total button
                Expanded(
                  child: PackageOptionButton(
                    label: 'Data in total',
                    isSelected: true, // Selected state
                  ),
                ),
                SizedBox(width: 10),
                // Data per day button
                Expanded(
                  child: PackageOptionButton(
                    label: 'Data per day',
                    isSelected: false,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            // SIM Card Validity section
            Text(
              'SIM card validity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Wrap(
              spacing: 10, // Space between buttons
              runSpacing: 10, // Space between rows of buttons
              children: [
                ValidityOptionButton(label: '7 days', isSelected: false),
                ValidityOptionButton(label: '14 days', isSelected: true),
                ValidityOptionButton(label: '28 days', isSelected: false),
                ValidityOptionButton(label: '30 days', isSelected: false),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable button widget for "Package type"
class PackageOptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const PackageOptionButton({super.key, 
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected
            ? ColorPalette.green.withOpacity(0.2)
            : ColorPalette.grey1.withOpacity(0.2), // Color based on selection
        border: Border.all(
          color: isSelected
              ? ColorPalette.green
              : Colors.black87, // Border color based on selection
        ),
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isSelected
                ? ColorPalette.green
                : Colors.black87, // Text color based on selection
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

// Reusable button widget for "SIM card validity"
class ValidityOptionButton extends StatelessWidget {
  final String label;
  final bool isSelected;

  const ValidityOptionButton({super.key, 
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.teal[100]
            : Colors.grey[300], // Color based on selection
        border: Border.all(
          color: isSelected
              ? Colors.teal
              : Colors.grey, // Border color based on selection
        ),
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isSelected
                ? Colors.teal
                : Colors.grey[600], // Text color based on selection
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
