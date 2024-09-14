import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Lorem ipsum has been the industry standard dummy text.',
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        TextButton(
          onPressed: () {
            // Expand to show full description
          },
          child: const Text('Read More'),
        ),
      ],
    );
  }
}
