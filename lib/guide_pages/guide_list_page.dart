import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:localize_sl/guide_pages/guide_detail_page.dart';
import 'package:localize_sl/guide_pages/guide_model.dart';

class GuideListPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(
          'Search',
          style: TextStyle(
              // fontWeight: FontWeight.bold,
              ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Add filter action here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('users')
            .where('user_role', whereIn: ["Guide", "Business"]).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.green,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text('No guides found'),
            );
          }

          var guides = snapshot.data!.docs
              .map((doc) => Guide.fromFirestore(
                  doc as DocumentSnapshot<Map<String, dynamic>>))
              .toList();

          return ListView.builder(
            itemCount: guides.length,
            itemBuilder: (context, index) {
              return GuideCard(guide: guides[index]);
            },
          );
        },
      ),
    );
  }
}

class GuideCard extends StatelessWidget {
  final Guide guide;

  GuideCard({required this.guide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuideDetailPage(userId: guide.documentId),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage(guide.profileImageUrl),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guide.username,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'LOCALIZE ${guide.user_role.toUpperCase()}',
                            style: TextStyle(
                                fontSize: 12,
                                color: const Color.fromARGB(137, 22, 1, 1)),
                          ),
                          Text(
                            'Languages: ${guide.languages.join(', ')}',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16.0),
                              SizedBox(width: 4.0),
                              Text(
                                '${guide.rating}',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 7.0),
                              Text(
                                '(${guide.reviews} Reviews)',
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 16.0),
                  ],
                ),
                SizedBox(height: 2.0),
                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: guide.tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: Colors.green, width: 0.7),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
