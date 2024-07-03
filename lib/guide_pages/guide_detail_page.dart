import 'guide_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'vacation_detail_page.dart';





class GuideDetailPage extends StatefulWidget {
  final Guide guide;

  GuideDetailPage({required this.guide});

  @override
  _GuideDetailPageState createState() => _GuideDetailPageState();
}

class _GuideDetailPageState extends State<GuideDetailPage> {
  int _selectedIndex = 0;
  List<DocumentSnapshot> memories = [];
  bool _isEmailFormExpanded = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 2) {
      fetchMemories();
    }
  }

  void fetchMemories() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('memories')
        .where('userId', isEqualTo: widget.guide.documentId)
        .get();
    setState(() {
      memories = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guide Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              // Handle favorite button press
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.guide.profilePictureUrl), // Add the actual image URL
              ),
              SizedBox(height: 16.0),
              Text(
                widget.guide.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.guide.bio,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Icon(Icons.star),
                      Text('${widget.guide.reviews} reviews'),
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.money),
                      Text('${widget.guide.reviews} Hourly rate'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16.0),
              Divider(),
              // Navigation Bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(Icons.card_giftcard, 'Packages', 0),
                  _buildNavItem(Icons.miscellaneous_services, 'Services', 1),
                  _buildNavItem(Icons.photo_album, 'Memories', 2),
                  _buildNavItem(Icons.contact_mail, 'Contact Me', 3),
                ],
              ),
              Divider(),
              SizedBox(height: 16.0),
              // Content based on selected index
              if (_selectedIndex == 0)... [
                Text(
                  'Available Packages',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 300.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 0.5,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                  ),
                  itemCount: widget.guide.packages.length,
                  itemBuilder: (context, index, realIdx) {
                    var package = widget.guide.packages[index];
                    
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VacationDetailPage(),
                          ),
                        );
                      },
                      child: ShortVideoThumbnail(
                        imageRef: package['image'],
                        description: package['price'],
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'Experience',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                CarouselSlider.builder(
                  options: CarouselOptions(
                    height: 200.0,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    viewportFraction: 0.8,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                  ),
                  itemCount: widget.guide.experiences.length,
                  itemBuilder: (context, index, realIdx) {
                    var experience = widget.guide.experiences[index];
                    return ExperienceThumbnail(
                      imageRef: experience['image'],
                      description: experience['description'],
                    );
                  },
                ),
            ]
              else if (_selectedIndex == 1)... [
                 SizedBox(
                  height: 250.0, // Adjust height as needed
                  child: ListWheelScrollView(
                    itemExtent: 150,
                    children: widget.guide.services.map((service) {
                      return ServiceCard(
                        day: service['day'],
                        time: service['time'],
                        title: service['title'],
                        description: service['description'],
                        attendees: service['attendees'],
                        imageRef: service['image'],
                      );
                    }).toList(),
                  ),
                ),
              ]
              else if (_selectedIndex == 2)... [
                 Text(
                  'Memories',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                if (memories.isEmpty)
                  Center(child: CircularProgressIndicator())
                else
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: memories.length,
                    itemBuilder: (context, index) {
                      var memory = memories[index].data() as Map<String, dynamic>;
                      return MemoryGridItem(
                        imageRef: memory['downloadURL'],
                        description: memory['caption'],
                      );
                    },
                  ),
              ]
              else if (_selectedIndex == 3)...[
                ContactPage(guide: widget.guide),
              ],
                
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle book mentoring
                },
                child: Text('Book Mentoring'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: _selectedIndex == index ? Colors.green : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              color: _selectedIndex == index ? Colors.green : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}




class ShortVideoThumbnail extends StatelessWidget {
  final String imageRef;
  final String description;

  const ShortVideoThumbnail({
    required this.imageRef,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
   Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(imageRef),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          description,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}

class ExperienceThumbnail extends StatelessWidget {
  final String imageRef;
  final String description;

  ExperienceThumbnail({required this.imageRef, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(imageRef),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          description,
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            backgroundColor: Colors.black54,
          ),
        ),
      ),
    );
  }
}

//               SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Handle book mentoring
//                 },
//                 child: Text('Book Mentoring'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class ServiceCard extends StatelessWidget {
  final String day;
  final String time;
  final String title;
  final String description;
  final String attendees;
  final String imageRef; // Add image reference

  ServiceCard({
    required this.day,
    required this.time,
    required this.title,
    required this.description,
    required this.attendees,
    required this.imageRef, // Initialize image reference
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200, // Adjust height as needed
      margin: EdgeInsets.symmetric(vertical: 3.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        image: DecorationImage(
          image: NetworkImage(imageRef),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    day.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Add avatars for attendees
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage('URL to Attendee\'s image'), // Add the actual image URL
                      ),
                      SizedBox(width: 4.0),
                      CircleAvatar(
                        radius: 12,
                        backgroundImage: NetworkImage('URL to Attendee\'s image'), // Add the actual image URL
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        attendees,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class MemoryGridItem extends StatelessWidget {
  final String imageRef;
  final String description;

  MemoryGridItem({required this.imageRef, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(imageRef),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(8.0),
          color: Color.fromRGBO(233, 233, 233, 1),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}





class ContactPage extends StatelessWidget {
  final Guide guide;

  ContactPage({required this.guide});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.0),
        Text(
          'Contact Me',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Don\'t hesitate to contact me for \nbookings and if you have any \nsuggestions on how I \ncan improve my service',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.0),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ContactCard(
              icon: Icons.phone,
              title: 'Call me',
              subtitle: 'For booking inquiries',
              onTap: () async {
                // Handle phone call
              },
            ),
            ContactCard(
              icon: Icons.email,
              title: 'Email me',
              subtitle: 'For all your queries',
              onTap: () async {
                // Handle email
              },
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'Contact me in Social Media',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16.0),
        ContactSocialMediaCard(
          icon: Icons.camera_alt,
          platform: 'Instagram',
          followers: 'vimoshtheguide',
          posts: '',
          url: guide.instagramUrl,
        ),
        ContactSocialMediaCard(
          icon: Icons.send,
          platform: 'Telegram',
          followers: 'vimoshtele',
          posts: '',
          url: guide.telegramUrl,
        ),
        ContactSocialMediaCard(
          icon: Icons.facebook,
          platform: 'Facebook',
          followers: 'Vimosh Vasanthakumar',
          posts: '',
          url: guide.facebookUrl,
        ),
        ContactSocialMediaCard(
          icon: Icons.chat,
          platform: 'WhatsUp',
          followers: 'Hello there! I use Whatsapp as well',
          posts: '',
          url: guide.whatsappUrl,
        ),
      ],
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  ContactCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 36.0),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactSocialMediaCard extends StatelessWidget {
  final IconData icon;
  final String platform;
  final String followers;
  final String posts;
  final String url;

  ContactSocialMediaCard({
    required this.icon,
    required this.platform,
    required this.followers,
    required this.posts,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // if (await canLaunch(url)) {
        //   await launch(url);
        // }
      },
      child: Card(
        child: ListTile(
          leading: Icon(icon),
          title: Text(platform),
          subtitle: Text('$followers • $posts'),
          trailing: Icon(Icons.share),
        ),
      ),
    );
  }
}


