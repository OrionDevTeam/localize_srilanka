import 'package:flutter/material.dart';

import 'categories.dart';
import 'vehicle_card.dart';

class VehicleList extends StatelessWidget {
  const VehicleList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          CategorySection(
            title: 'Top Rated Vehicles',
            vehicleItems: [
              VehicleItem(
                name: 'Yamaha Scooter',
                availableDate: 'Available for 3 Days',
                seats: '2 Seats',
                price: '\$18.32/day',
                imageUrl: 'assets/vehicle/bike2.jpg',
                rating: '5.00',
              ),
              VehicleItem(
                name: 'Yahama FZ',
                availableDate: 'Available for 3 Days',
                seats: '2 Seats',
                price: '\$27.00/hour',
                imageUrl: 'assets/vehicle/bike1.jpg',
                rating: '5.00',
              ),
            ],
          ),
          CategorySection(
            title: 'Most Popular Vehicles',
            vehicleItems: [
              VehicleItem(
                name: 'Suzuki Alto',
                availableDate: 'Available for 3 Days',
                seats: '5 Seats',
                price: '\$24.32/day',
                imageUrl: 'assets/vehicle/car1.jpg',
                rating: '5.00',
              ),
              VehicleItem(
                name: 'Bajaj Three Wheeler',
                availableDate: 'Available for 2 Days',
                seats: '4 Seats',
                price: '\$18.32/Day',
                imageUrl: 'assets/vehicle/auto.jpeg',
                rating: '5.00',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
