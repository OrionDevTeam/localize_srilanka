import 'package:flutter/material.dart';

class VehicleInfoSection extends StatelessWidget {
  final String vehicleName;
  final String pricePerHour;
  final String rating;

  const VehicleInfoSection(
      {super.key,
      required this.vehicleName,
      required this.pricePerHour,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                vehicleName,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.star,
                color: Colors.yellow,
              ),
              Text(
                rating,
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
