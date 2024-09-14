import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localize_sl/colorpalate.dart';
import 'package:localize_sl/guide_pages/guide_detail_page.dart';
import 'package:localize_sl/guide_pages/guide_list_page.dart';

import 'widgets/guide_card.dart';

class GuidePlace extends StatelessWidget {
  final String place;

  const GuidePlace({super.key, required this.place});

  Future<List<Map<String, dynamic>>> fetchGuides() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('user_role', isEqualTo: 'Guide')
        .where('location', isEqualTo: place)
        .get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }

  @override
  @override
  @override
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchGuides(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Colors.green));
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No Guides Found'));
        } else {
          List<Map<String, dynamic>> guides = snapshot.data!;
          // Add the button to the guides list
          guides.add({
            'isButton': true, // Flag to identify it as a button item
          });

          return ListView.separated(
            itemCount: guides.length,
            separatorBuilder: (context, index) => const SizedBox(height: 0),
            itemBuilder: (context, index) {
              var item = guides[index];
              if (item.containsKey('isButton') && item['isButton']) {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GuideListPage(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: ColorPalette.green, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.add, color: ColorPalette.green),
                    label: const Text(
                      'See all Guides and Businesses',
                      style: TextStyle(color: ColorPalette.green, fontSize: 16),
                    ),
                  ),
                );
              } else {
                var guide = item;
                return GuideCardWidget(
                    imageUrl: guide['profileImageUrl'].toString(),
                    title: guide['username'].toString(),
                    location: guide['location'].toString(),
                    rating: guide['rating'].toString(),
                    OnTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GuideDetailPage(
                            userId: guide['documentId'],
                          ),
                        ),
                      );
                    });
                // return GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => GuideDetailPage(
                //           userId: guide['documentId'],
                //         ),
                //       ),
                //     );
                //   },
                //   child: Column(
                //     children: [
                //       const SizedBox(height: 8),
                //       Padding(
                //         padding: const EdgeInsets.all(0),
                //         child: Container(
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(18),
                //             border: Border.all(
                //               color: Colors.grey,
                //               width: 0.7,
                //             ),
                //           ),
                //           child: Padding(
                //             padding: const EdgeInsets.only(left: 8.0),
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.start,
                //               children: [
                //                 Expanded(
                //                   flex: 1,
                //                   child: ClipRRect(
                //                     borderRadius:
                //                         const BorderRadius.all(Radius.circular(12)),
                //                     child: Image.network(
                //                       guide['profileImageUrl'],
                //                       height: 100,
                //                       fit: BoxFit.cover,
                //                     ),
                //                   ),
                //                 ),
                //                 const SizedBox(width: 18),
                //                 Expanded(
                //                   flex: 1,
                //                   child: Column(
                //                     crossAxisAlignment:
                //                         CrossAxisAlignment.start,
                //                     children: [
                //                       const SizedBox(height: 4),
                //                       Text(
                //                         guide['username'],
                //                         style: const TextStyle(
                //                           fontSize: 16,
                //                           fontWeight: FontWeight.bold,
                //                         ),
                //                       ),
                //                       const SizedBox(height: 6),
                //                       Row(
                //                         children: [
                //                           const Icon(Icons.location_on_outlined,
                //                               color: Colors.grey),
                //                           const SizedBox(width: 4),
                //                           Text(
                //                             '${guide['location']}',
                //                             style: TextStyle(
                //                               fontSize: 14,
                //                               color: Colors.grey[600],
                //                             ),
                //                           ),
                //                         ],
                //                       ),
                //                       const SizedBox(height: 8),
                //                       Row(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.start,
                //                         children: [
                //                           const Icon(Icons.star,
                //                               color: Colors.orange),
                //                           const SizedBox(width: 4),
                //                           Text('${guide['rating']}'),
                //                           const SizedBox(width: 4),
                //                         ],
                //                       ),
                //                       const SizedBox(height: 4),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //       const SizedBox(height: 8),
                //     ],
                //   ),
                // );
              }
            },
          );
        }
      },
    );
  }
}
