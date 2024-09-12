import 'package:flutter/material.dart';

import 'booknow_bottom.dart';
import 'description.dart';
import 'host_info.dart';
import 'pickup_return.dart';
import 'trip_dates.dart';
import 'vehicleInfoScreen.dart';

class VehicleDetailPage extends StatelessWidget {
  final String vehicleName;
  final String pricePerHour;
  final String imageUrl;
  final String rating;

  const VehicleDetailPage(
      {Key? key,
      required this.vehicleName,
      required this.pricePerHour,
      required this.imageUrl,
      required this.rating})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(vehicleName),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(imageUrl), // Placeholder for vehicle image
              ),
              SizedBox(height: 16),
              VehicleInfoSection(
                  vehicleName: vehicleName,
                  pricePerHour: pricePerHour,
                  rating: rating),
              SizedBox(height: 16),
              HostInfoSection(),
              SizedBox(height: 16),
              TripDatesSection(),
              Divider(),
              PickupReturnSection(),
              SizedBox(height: 16),
              DescriptionSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BookNowBar(pricePerHour: pricePerHour),
    );
  }
}
