import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'adventureHome.dart';

class AdventurePage extends StatefulWidget {
  final String place;
  final String adventure;

  AdventurePage({required this.place, required this.adventure});

  @override
  _SurfingPageState createState() => _SurfingPageState();
}

class _SurfingPageState extends State<AdventurePage> {
  Future<List<Map<String, dynamic>>> fetchSurfingProviders() async {
    List<Map<String, dynamic>> providers = [];
    CollectionReference surfingCollection = FirebaseFirestore.instance
        .collection('adventures/${widget.place}/${widget.adventure}');

    QuerySnapshot querySnapshot = await surfingCollection.get();
    for (var doc in querySnapshot.docs) {
      providers.add(doc.data() as Map<String, dynamic>);
    }

    return providers;
  }

  late Future<List<Map<String, dynamic>>> _surfingProviders;

  @override
  void initState() {
    super.initState();
    _surfingProviders = fetchSurfingProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${widget.adventure}',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 10),
            Text(
              'in ${widget.place}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _surfingProviders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(color: Colors.green));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No Surfing Providers Found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var provider = snapshot.data![index];
                provider.values
                    .where((value) => value.toString().startsWith('https'))
                    .toList();

                // Assuming you want to arrange items horizontally (in a row)
                return Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          child: Image.network(
                            provider['titleImageUrl'],
                            height: 132,
                            width: 152,
                            fit: BoxFit
                                .cover, // or BoxFit.fill based on preference
                          ),
                        ),

                        SizedBox(width: 20),
                        // Provider details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text(
                                '${provider['name']}!',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_half_outlined,
                                    size: 16,
                                    color: Colors.orange,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    provider['rating'].toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    'LKR ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                  Text(
                                    provider['rate'].toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    ' / hour',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Implement booking logic here
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AdventureHomePage(
                                            provider: provider,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: 124,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF0EFEF),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Book Now',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF3774FF),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
