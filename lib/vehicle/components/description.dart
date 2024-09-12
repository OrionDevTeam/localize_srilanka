import 'package:flutter/material.dart';

class DescriptionSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Lorem ipsum has been the industry standard dummy text.',
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
        ),
        TextButton(
          onPressed: () {
            // Expand to show full description
          },
          child: Text('Read More'),
        ),
      ],
    );
  }
}
