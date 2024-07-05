import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localize_sl/guide_pages/guide_detail_page.dart';
import 'package:localize_sl/guide_pages/guide_list_page.dart';

class GuidePlace extends StatelessWidget {
  final String place;

  GuidePlace({required this.place});

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
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Guides Found'));
        } else {
          List<Map<String, dynamic>> guides = snapshot.data!;
          // Add the button to the guides list
          guides.add({
            'isButton': true, // Flag to identify it as a button item
          });

          return ListView.separated(
            itemCount: guides.length,
            separatorBuilder: (context, index) => SizedBox(height: 0),
            itemBuilder: (context, index) {
              var item = guides[index];
              if (item.containsKey('isButton') && item['isButton']) {
                // Render the button here
                return Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextButton.icon(
                    onPressed: () {
                      GuideListPage();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.green, width: 1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.add, color: Colors.green),
                    label: Text(
                      'See all Guides and Businesses',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                  ),
                );
              } else {
                // Render guide item
                var guide = item;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GuideDetailPage(
                          userId: guide['documentId'],
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 8),
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.grey,
                              width: 0.7,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                    child: Image.network(
                                      guide['profileImageUrl'],
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 18),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text(
                                        guide['username'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(Icons.location_on_outlined,
                                              color: Colors.grey),
                                          SizedBox(width: 4),
                                          Text(
                                            '${guide['location']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Icon(Icons.star,
                                              color: Colors.orange),
                                          SizedBox(width: 4),
                                          Text('${guide['rating']}'),
                                          SizedBox(width: 4),
                                        ],
                                      ),
                                      SizedBox(height: 4),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                );
              }
            },
          );
        }
      },
    );
  }
}
