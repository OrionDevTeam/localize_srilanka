import 'package:flutter/material.dart';

import 'components/vehicle_list.dart';

class VehicleScreen extends StatelessWidget {
  const VehicleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(160.0), // Adjust the height as needed
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(18.0)), // Add border radius to the bottom
          child: AppBar(
            backgroundColor: const Color(0xFF2A966C),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Column(
                children: [
                  const Text(
                    'Rent a Vehicle',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              12.0), // Border radius for the TextField
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: const Column(
        children: [
          Expanded(child: VehicleList()),
        ],
      ),
    );
  }
}
