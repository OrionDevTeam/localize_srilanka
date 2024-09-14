import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localize_sl/colorpalate.dart';

import 'adventureHome.dart';
import 'widget/adventureCard.dart';

class AdventurePage extends StatefulWidget {
  final String place;
  final String adventure;

  const AdventurePage(
      {super.key, required this.place, required this.adventure});

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Surfing Providers',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _surfingProviders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No Surfing Providers Found'));
          } else {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    color: ColorPalette.grey1,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Choose your adventure',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: Colors.white, // Red border for enabled state
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Colors.grey, // Red border for focused state
                            width: 1.0,
                          ),
                        ), // No border
                      ),
                    ),
                  ),
                ),

                // Gap
                const SizedBox(height: 10),
                // Scrollable list of cards
                Expanded(
                  child: Container(
                    color: ColorPalette.grey1,
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var provider = snapshot.data![index];
                        provider.values
                            .where(
                                (value) => value.toString().startsWith('https'))
                            .toList();
                        return AdventureCard(
                          provider: provider['name'].toString() ?? '',
                          reviews: provider['reviewsCount'].toString() ?? '0',
                          duration: provider['duration'].toString() ?? '0',
                          rating: provider['rating'].toString() ?? '0',
                          location: widget.place.toString() ?? '0',
                          price: provider['rate'].toString() ?? '0',
                          imagePath: provider['titleImageUrl'] ?? '',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdventureHomePage(
                                  provider: provider,
                                ),
                              ),
                            );
                          },
                        );
                        // Assuming you want to arrange items horizontally (in a row)
                        // return Padding(
                        //   padding: const EdgeInsets.only(
                        //     bottom: 16.0,
                        //     left: 12.0,
                        //     right: 12.0,
                        //   ),
                        //   child: Container(
                        //     padding: const EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //       border: Border.all(color: Colors.grey),
                        //       borderRadius: const BorderRadius.all(Radius.circular(18)),
                        //     ),
                        //     child: Row(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         ClipRRect(
                        //           borderRadius:
                        //               const BorderRadius.all(Radius.circular(18)),
                        //           child: Image.network(
                        //             provider['titleImageUrl'],
                        //             height: 132,
                        //             width: 152,
                        //             fit: BoxFit
                        //                 .cover, // or BoxFit.fill based on preference
                        //           ),
                        //         ),

                        //         const SizedBox(width: 20),
                        //         // Provider details
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment: CrossAxisAlignment.start,
                        //             children: [
                        //               const SizedBox(height: 5),
                        //               Text(
                        //                 '${provider['name']}!',
                        //                 style: const TextStyle(
                        //                     fontSize: 16, fontWeight: FontWeight.bold),
                        //               ),
                        //               const SizedBox(height: 5),
                        //               Row(
                        //                 children: [
                        //                   const Icon(
                        //                     Icons.star_half_outlined,
                        //                     size: 16,
                        //                     color: Colors.orange,
                        //                   ),
                        //                   const SizedBox(width: 5),
                        //                   Text(
                        //                     provider['rating'].toString(),
                        //                     style: const TextStyle(
                        //                         fontSize: 15,
                        //                         fontWeight: FontWeight.bold,
                        //                         color: Colors.grey),
                        //                   ),
                        //                 ],
                        //               ),
                        //               Row(
                        //                 children: [
                        //                   const Text(
                        //                     'LKR ',
                        //                     style: TextStyle(
                        //                         fontSize: 14,
                        //                         fontWeight: FontWeight.bold,
                        //                         color: Colors.grey),
                        //                   ),
                        //                   Text(
                        //                     provider['rate'].toString(),
                        //                     style: const TextStyle(
                        //                         fontSize: 16,
                        //                         fontWeight: FontWeight.bold,
                        //                         color: Colors.black),
                        //                   ),
                        //                   const Text(
                        //                     ' / hour',
                        //                     style: TextStyle(
                        //                         fontSize: 14,
                        //                         fontWeight: FontWeight.bold,
                        //                         color: Colors.grey),
                        //                   ),
                        //                 ],
                        //               ),
                        //               const SizedBox(height: 10),
                        //               Row(
                        //                 mainAxisAlignment: MainAxisAlignment.end,
                        //                 children: [
                        //                   GestureDetector(
                        //                     onTap: () {
                        //                       // Implement booking logic here
                        //                       Navigator.push(
                        //                         context,
                        //                         MaterialPageRoute(
                        //                           builder: (context) =>
                        //                               AdventureHomePage(
                        //                             provider: provider,
                        //                           ),
                        //                         ),
                        //                       );
                        //                     },
                        //                     child: Container(
                        //                       width: 124,
                        //                       height: 36,
                        //                       decoration: BoxDecoration(
                        //                         color: const Color(0xFFF0EFEF),
                        //                         borderRadius:
                        //                             BorderRadius.circular(24.0),
                        //                       ),
                        //                       child: const Center(
                        //                         child: Text(
                        //                           'Book Now',
                        //                           style: TextStyle(
                        //                             fontSize: 16,
                        //                             fontWeight: FontWeight.bold,
                        //                             color: Color(0xFF3774FF),
                        //                           ),
                        //                         ),
                        //                       ),
                        //                     ),
                        //                   ),
                        //                 ],
                        //               )
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // );
                      },
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
