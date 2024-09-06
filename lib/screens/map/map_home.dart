import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import 'location.dart';

class MapS extends StatelessWidget {
  final String apiKey = "AIzaSyA3FOuDQdJiRFn8c_9UEkTc3DeMyECjMB0";
  final bool showBackButton; // Boolean variable for back button visibility

  const MapS({super.key, required this.showBackButton});

  @override
  Widget build(BuildContext context) {
    return MapScreen(apiKey: apiKey, showBackButton: showBackButton);
  }
}

class MapScreen extends StatefulWidget {
  final String apiKey;
  final bool showBackButton; // Boolean variable for back button visibility

  const MapScreen({required this.apiKey, required this.showBackButton, super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController _searchController = TextEditingController();

  static const LatLng _center = LatLng(5.9414224, 80.4622485);
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: _center,
    zoom: 13.0,
  );

  final Set<Marker> _markers = {};
  final Offset _fabPosition = const Offset(0, 180); // Initial position

  @override
  void initState() {
    super.initState();
    fetchMarkers().then((markers) {
      setState(() {
        _markers.addAll(markers);
      });
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialCameraPosition,
            myLocationEnabled: true,
            markers: _markers,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
          ),
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Container(
              height: 48,
              // padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  if (widget.showBackButton) // Conditionally display back button
                    Padding(
                      padding: const EdgeInsets.only(bottom:1.0),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Search for a place...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) => _searchPlace(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.blue),
                    onPressed: _searchPlace,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _searchPlace() async {
    final query = _searchController.text;
    if (query.isEmpty) {
      return;
    }

    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$query&inputtype=textquery&fields=geometry&key=${widget.apiKey}'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['candidates'] != null && data['candidates'].isNotEmpty) {
        final location = data['candidates'][0]['geometry']['location'];
        final latLng = LatLng(location['lat'], location['lng']);

        _addMarker(latLng, query);
        _goToPlace(latLng);
      } else {
        _showError('Place not found');
      }
    } else {
      _showError('Failed to fetch place details');
    }
  }

  void _addMarker(LatLng latLng, String placeName) {
    final markerId =
        placeName.replaceAll(' ', '_'); // Create a unique marker ID

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: latLng,
          infoWindow: InfoWindow(
            title: placeName, // Title displayed when marker is tapped
          ),
          onTap: () =>
              _showDetailsDialog(context, markerId), // Handle marker tap
        ),
      );
    });

    print("-------------------------------------------");
    print('Marker added: $placeName ---- $latLng');
    print("-------------------------------------------");
  }

  Future<void> _goToPlace(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    final CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 14,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  void _showDetailsDialog(BuildContext context, String documentId) async {
    // Fetch data from Firestore
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('markers')
        .doc(documentId)
        .get();

    if (documentSnapshot.exists) {
      var data = documentSnapshot.data() as Map<String, dynamic>;
      String imageUrl = data['imageUrl'];
      String place = data['place'];
      String description = data['description'];
      String location = data['location'];
      String rating = data['rating'];
      String n = data['n'];
      List<String> experiencesL = List<String>.from(data['experiences']);

      showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 420,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 100, left: 16, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Location(
                            imageUrl: imageUrl,
                            description: description,
                            title: documentId.replaceAll('_', ' '),
                            location: location,
                            rating: rating,
                            tags: experiencesL,
                            n: n,
                            place: place,
                          ),
                        ),
                      );
                    },
                    child: LocationCard(
                      imageUrl: imageUrl,
                      title: documentId.replaceAll('_', ' '),
                      location: location,
                      rating: rating,
                      n: n,
                      tags: experiencesL,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      // Handle document not found
      _showError('Marker details not found.');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<List<Marker>> fetchMarkers() async {
    List<Marker> markers = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('markers').get();

    for (var doc in querySnapshot.docs) {
      // Check if the document contains the expected fields
      if (doc.exists &&
          doc.data() != null &&
          (doc.data() as Map<String, dynamic>).containsKey('latitude') &&
          (doc.data() as Map<String, dynamic>).containsKey('longitude') &&
          (doc.data() as Map<String, dynamic>).containsKey('title')) {
        double latitude = doc['latitude'];
        double longitude = doc['longitude'];
        String title = doc['title'];

        markers.add(
          Marker(
            markerId: MarkerId(title),
            position: LatLng(latitude, longitude),
            infoWindow: InfoWindow(title: title),
            onTap: () =>
                _showDetailsDialog(context, title), // Define your own handler
          ),
        );
      } else {
        print("-------------------------------------------");
        print('Document ${doc.id} is missing expected fields.');
        print("-------------------------------------------");
      }
    }

    return markers;
  }
}

class LocationCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String location;
  final String rating;
  final List<String> tags;
  final String n;

  const LocationCard({super.key, 
    required this.n,
    required this.tags,
    required this.imageUrl,
    required this.title,
    required this.location,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(imageUrl, fit: BoxFit.cover),
          ListTile(
            title: Text(title),
            subtitle: Text(location),
            trailing: Text(rating),
          ),
          Wrap(
            spacing: 8.0,
            children: tags.map((tag) {
              return Chip(label: Text(tag));
            }).toList(),
          ),
        ],
      ),
    );
  }
}
