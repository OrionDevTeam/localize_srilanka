import 'package:flutter/material.dart';

import 'vehicleDetails.dart';

class VehicleItem extends StatelessWidget {
  final String name;
  final String availableDate;
  final String seats;
  final String price;
  final String imageUrl;
  final String rating;

  VehicleItem({
    required this.name,
    required this.availableDate,
    required this.seats,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the vehicle details page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VehicleDetailPage(
              vehicleName: name,
              pricePerHour: price,
              imageUrl: imageUrl,
              rating: rating,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200,
          height: 300,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    imageUrl,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Text(availableDate),
                      Text(seats,
                          style: TextStyle(
                            fontSize: 14,
                          )),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            price,
                            style: TextStyle(
                                color: Color(0xFF2A966C),
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
