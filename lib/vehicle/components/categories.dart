import 'package:flutter/material.dart';
import 'vehicle_card.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<VehicleItem> vehicleItems;

  CategorySection({required this.title, required this.vehicleItems});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {},
                child: Text('View All',
                    style: TextStyle(
                      color: Color(0xFF2A966C),
                    )),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: vehicleItems.length,
            itemBuilder: (context, index) {
              return vehicleItems[index];
            },
          ),
        ),
      ],
    );
  }
}
