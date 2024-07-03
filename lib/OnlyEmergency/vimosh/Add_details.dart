import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localize_sl/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String apiKey = await fetchApiKey(); // Fetch API key from Firestore

  runApp(MyApp(apiKey: apiKey));
}

Future<String> fetchApiKey() {
  return FirebaseFirestore.instance
      .collection('API keys')
      .doc('google_map')
      .get()
      .then((doc) {
    if (doc.exists) {
      return doc.data()?['google']; // Adjust 'google' to match your field name
    } else {
      return '';
    }
  });
}

class MyApp extends StatelessWidget {
  final String apiKey;

  MyApp({required this.apiKey});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MapScreen(apiKey: apiKey),
    );
  }
}

class MapScreen extends StatefulWidget {
  final String apiKey;

  MapScreen({required this.apiKey});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final TextEditingController _searchController = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.937675, 80.465649),
    zoom: 14.58,
  );

  Set<Marker> _markers = {};
  final LatLng _center = const LatLng(5.937675, 80.465649);

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
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 13.0,
            ),
            myLocationEnabled: true,
            markers: Set<Marker>.of(_markers),
          ),
          Positioned(
            top: 60,
            left: 16,
            right: 16,
            child: Container(
              height: 48,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search for a place...',
                        border: InputBorder.none,
                      ),
                      onSubmitted: (value) => _searchPlace(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: Colors.blue),
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
              _setDetailsDialog(context, markerId, latLng), // Handle marker tap
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
      zoom: 17,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
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

    querySnapshot.docs.forEach((doc) {
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
            onTap: () {}, // Define your own handler
          ),
        );
      } else {
        print("-------------------------------------------");
        print('Document ${doc.id} is missing expected fields.');
        print("-------------------------------------------");
      }
    });

    return markers;
  }
}

_setDetailsDialog(BuildContext context, String markerId, LatLng latLng) {
  TextEditingController titleController = TextEditingController();
  TextEditingController ratingController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController nController = TextEditingController();
  TextEditingController experience1Controller = TextEditingController();
  TextEditingController experience2Controller = TextEditingController();
  TextEditingController experience3Controller = TextEditingController();
  File? _image;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Marker Details'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: ratingController,
                    decoration: InputDecoration(labelText: 'Rating'),
                  ),
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(labelText: 'Location'),
                  ),
                  TextField(
                    controller: nController,
                    decoration: InputDecoration(labelText: 'N'),
                  ),
                  TextField(
                    controller: experience1Controller,
                    decoration: InputDecoration(labelText: 'Experience 1'),
                  ),
                  TextField(
                    controller: experience2Controller,
                    decoration: InputDecoration(labelText: 'Experience 2'),
                  ),
                  TextField(
                    controller: experience3Controller,
                    decoration: InputDecoration(labelText: 'Experience 3'),
                  ),
                  SizedBox(height: 20),
                  _image == null
                      ? Text('No image selected.')
                      : Image.file(_image!),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      final XFile? pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      setState(() {
                        if (pickedFile != null) {
                          _image = File(pickedFile.path);
                        } else {
                          print('No image selected.');
                        }
                      });
                    },
                    child: Text('Pick Image'),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () async {
                  String rating = ratingController.text;
                  String location = locationController.text;
                  String n = nController.text.toString();
                  List<String> experiences = [
                    experience1Controller.text,
                    experience2Controller.text,
                    experience3Controller.text,
                  ];

                  // Extract latitude and longitude from LatLng
                  double latitude = latLng.latitude;
                  double longitude = latLng.longitude;

                  // Save data to Firestore
                  await FirebaseFirestore.instance
                      .collection('markers')
                      .doc(markerId)
                      .set({
                    'title': markerId,
                    'latitude': latitude,
                    'longitude': longitude,
                    'rating': rating,
                    'location': location,
                    'n': '$n+',
                    'experiences': experiences,
                    'imageUrl': _image != null
                        ? await uploadImageAndReturnUrl(
                            _image!, markerId, context)
                        : null,
                  });

                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Save'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    },
  );
}

Future<String> uploadImageAndReturnUrl(
    File imageFile, String markerId, BuildContext context) async {
  try {
    final fileName = imageFile.path.split('/').last;
    final storageRef =
        FirebaseStorage.instance.ref().child('Map images/South/$fileName');
    final uploadTask = storageRef.putFile(imageFile);

    final snapshot = await uploadTask.whenComplete(() => {});
    final downloadUrl = await snapshot.ref.getDownloadURL();

    print('Uploaded image URL: $downloadUrl');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Image uploaded successfully!')),
    );

    return downloadUrl;
  } catch (e) {
    print('Failed to upload image: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to upload image.')),
    );
    return ''; // Handle error case
  }
}
