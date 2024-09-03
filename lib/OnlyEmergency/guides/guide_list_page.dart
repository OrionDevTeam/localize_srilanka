import 'package:flutter/material.dart';
import 'guide_model.dart';
import 'guide_service.dart';
import 'guide_detail_page.dart';

class GuidesList extends StatefulWidget {
  const GuidesList({super.key});

  @override
  _GuidesListState createState() => _GuidesListState();
}

class _GuidesListState extends State<GuidesList> {
  late Future<List<Guide>> futureGuides;

  @override
  void initState() {
    super.initState();
    futureGuides = GuideService().fetchGuides();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Add your back button action here
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Search Guides',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Add filter action here
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Guide>>(
        future: futureGuides,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No guides available'));
          }

          final guides = snapshot.data!;

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

  const GuideCard({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GuideDetailPage(guideId: guide.id),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.black),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    FutureBuilder<String>(
                      future: getProfilePictureUrl(guide.id),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey[300],
                          );
                        }
                        if (snapshot.hasError ||
                            !snapshot.hasData ||
                            snapshot.data!.isEmpty) {
                          return CircleAvatar(
                            radius: 30.0,
                            backgroundColor: Colors.grey[300],
                            child: const Icon(Icons.error),
                          );
                        }
                        print('Profile picture URL: ${snapshot.data}');
                        return CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(snapshot.data!),
                        );
                      },
                    ),
                    const SizedBox(width: 20.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            guide.name,
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
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
                              const Icon(Icons.star, color: Colors.amber, size: 16.0),
                              const SizedBox(width: 4.0),
                              Text(
                                '${guide.rating}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 7.0),
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
                    const Icon(Icons.arrow_forward_ios, size: 16.0),
                  ],
                ),
                const SizedBox(height: 2.0),
                Text(
                  guide.description,
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Wrap(
                  spacing: 4.0,
                  runSpacing: 4.0,
                  children: guide.tags.map((tag) {
                    return Chip(
                      label: Text(tag),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
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
