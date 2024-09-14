import 'package:flutter/material.dart';
import 'package:localize_sl/colorpalate.dart';

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
              : Colors.black38, // Border color based on selection
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
                : Colors.black38, // Text color based on selection
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
