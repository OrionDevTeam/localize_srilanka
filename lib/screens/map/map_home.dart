import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:localize_sl/floating_chat.dart';

import 'location.dart';

class MapS extends StatelessWidget {
  final String apiKey = "AIzaSyA3FOuDQdJiRFn8c_9UEkTc3DeMyECjMB0";
  final bool showBackButton;
  const MapS({super.key, required this.showBackButton});

  @override
  Widget build(BuildContext context) {
    return MapScreen(apiKey: apiKey, showBackButton: showBackButton);
  }
}

class MapScreen extends StatefulWidget {
  final String apiKey;
  final bool showBackButton;
  const MapScreen({required this.apiKey, required this.showBackButton, super.key});


  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController _searchController = TextEditingController();

  static const LatLng _center =
      LatLng(5.958809599999999, 80.40584129999999);
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: _center,
    zoom: 13.0,
  );

  final Set<Marker> _markers = {};
// Initial position

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
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  ),
                ],
              ),
              child:Row(
                children: [
                  if (widget.showBackButton) // Conditionally display the back button
                    Padding(
                      padding: const EdgeInsets.only(right:10),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.blue),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  SizedBox(width: widget.showBackButton ? 8 : 0), // Adjust spacing if back button is present
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
          const FloatingChatButton(),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        color: Colors.black.withOpacity(0.4),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(width: 8),
                                Text(
                                  title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 8),
                                      const Icon(
                                        Icons.location_on_outlined,
                                        color: Colors.white,
                                        size: 12,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        location,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            const Icon(Icons.star,
                                                color: Colors.orange),
                                            const SizedBox(width: 4),
                                            Text(
                                              rating.toString(),
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(width: 18),
                    Text(
                      "Guides offer $n experiences here",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const SizedBox(width: 10),
                    for (var tag in tags) ...{
                      Chip(
                        label: Text(tag),
                        backgroundColor: const Color(0xFFE4E7E9),
                        labelStyle: const TextStyle(color: Color(0xFF169C8C)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(
                            color: Color(0xFF169C8C),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                    },
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}