import 'package:flutter/material.dart';
import 'package:localize_sl/experience/guide_details.dart';

List<Map<String, dynamic>> guides = [
  {
    'name': 'Vimosh Vasantthakumar',
    'image': 'assets/vimosh/g6.JPG',
    'verified': true,
    'rating': 4.2,
    'reviews': 12,
    'languages': ['English', 'Spanish', 'French'],
    'tags': ['Adventure', 'History', 'Nature'],
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non diam eu diam efficitur euismod.'
  },
  {
    'name': 'Kavienan Jegatheeshan',
    'image': 'assets/vimosh/g1.jpg',
    'verified': true,
    'rating': 4.0,
    'reviews': 19,
    'languages': ['English', 'Arabic', 'French'],
    'tags': ['Adventure', 'History', 'City Tour'],
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non diam eu diam efficitur euismod.'
  },
  {
    'name': 'Varun Poobalaraja',
    'image': 'assets/vimosh/g7.png',
    'verified': true,
    'rating': 4.0,
    'reviews': 8,
    'languages': ['English', 'Spanish', 'French'],
    'tags': ['Adventure', 'Food Tour', 'Nature'],
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non diam eu diam efficitur euismod.'
  },
  {
    'name': 'Aadhirai Varun',
    'image': 'assets/vimosh/g3.jpg',
    'verified': true,
    'rating': 3.9,
    'reviews': 11,
    'languages': ['English', 'Spanish', 'French'],
    'tags': ['Adventure', 'Photography', 'Nature'],
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non diam eu diam efficitur euismod.'
  },
  {
    'name': 'Aadithiyan Mathuranesan',
    'image': 'assets/vimosh/g4.jpg',
    'verified': true,
    'rating': 3.8,
    'reviews': 17,
    'languages': ['English', 'Hindi', 'Bengali'],
    'tags': ['Adventure', 'PHOTOGRAPHY', 'Wildlife Safari'],
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non diam eu diam efficitur euismod.'
  },
  {
    'name': 'Birunthaban Rajendram',
    'image': 'assets/vimosh/g5.jpg',
    'verified': true,
    'rating': 4.0,
    'reviews': 12,
    'languages': ['English', 'Russian', 'French'],
    'tags': ['Cultural Experiences', 'History', 'Nature'],
    'description':
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non diam eu diam efficitur euismod.'
  },
];

class GuidesInfoSection extends StatefulWidget {
  const GuidesInfoSection({super.key});

  @override
  State<GuidesInfoSection> createState() => _GuidesInfoSectionState();
}

class _GuidesInfoSectionState extends State<GuidesInfoSection> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Scrollable content
        SingleChildScrollView(
          padding: const EdgeInsets.all(20), // Adjust padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              // Guide Widgets (Dynamically created using guides list)
              for (int i = 0; i < guides.length; i += 2)
                Row(
                  children: [
                    Expanded(
                      child: GuideCard(
                        name: guides[i]['name'],
                        image: guides[i]['image'],
                        verified: guides[i]['verified'],
                        rating: guides[i]['rating'],
                        reviews: guides[i]['reviews'],
                        languages: guides[i]['languages'],
                        tags: guides[i]['tags'],
                        description: guides[i]['description'],
                      ),
                    ),
                    const SizedBox(width: 20),
                    if (i + 1 < guides.length)
                      Expanded(
                        child: GuideCard(
                          name: guides[i + 1]['name'],
                          image: guides[i + 1]['image'],
                          verified: guides[i + 1]['verified'],
                          rating: guides[i + 1]['rating'],
                          reviews: guides[i + 1]['reviews'],
                          languages: guides[i + 1]['languages'],
                          tags: guides[i + 1]['tags'],
                          description: guides[i + 1]['description'],
                        ),
                      ),
                  ],
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),

        // Search Bar and Filter Icon
        Positioned(
          top: 0,
          right: 20,
          left: 20,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search guides...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    // Implement search functionality here
                  },
                ),
                const SizedBox(width: 10),

                // Filter Icon
                GestureDetector(
                  onTap: () {
                    // Implement filter functionality here
                  },
                  child: const Icon(Icons.filter_list),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class GuideCard extends StatelessWidget {
  final String name;
  final String image;
  final bool verified;
  final double rating;
  final int reviews;
  final List<String> languages;
  final List<String> tags;
  final String description;

  const GuideCard({super.key, 
    required this.name,
    required this.image,
    required this.verified,
    required this.rating,
    required this.reviews,
    required this.languages,
    required this.tags,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const GuideDetailsPage(
              title: "Guide Details",
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(image),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        if (verified)
                          const Icon(
                            Icons.verified,
                            color: Colors.green,
                            size: 20,
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star, color: Colors.yellow),
                        const Icon(Icons.star_border, color: Colors.yellow),
                        Text('$rating ($reviews reviews)'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Languages: ${languages.join(', ')}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 5,
              children: [
                for (var tag in tags) Chip(label: Text(tag)),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: 400,
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const GuideDetailsPage(
                        title: "Guide Details",
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
