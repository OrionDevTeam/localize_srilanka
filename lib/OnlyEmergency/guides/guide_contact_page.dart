import 'package:flutter/material.dart';
import 'guide_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatefulWidget {
  final Guide guide;

  const ContactPage({super.key, required this.guide});

  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  bool _isEmailFormExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Contact Me',
            style: TextStyle(
              fontWeight: FontWeight.bold, // Making text bold
              fontSize: 20, // Adjust font size as needed
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: () async {
              
            },
            child: Card(
              child: ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Contact Number'),
                subtitle: Text(widget.guide.contactNumber),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isEmailFormExpanded = !_isEmailFormExpanded;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: Card(
                child: _isEmailFormExpanded
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            
                            const TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelText: 'First name*',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:Colors.grey,
                                  ) ,
                                  ),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Last name*',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:Colors.grey,
                                  ) ,
                                  ),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const TextField(
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelText: 'E-mail*',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:Colors.grey,
                                  ) ,
                                  ),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            const TextField(
                              maxLines: null,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Drop a message*',
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color:Colors.grey,
                                  ) ,
                                  ),
                                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black))
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            ElevatedButton(
                              onPressed: () {
                                // Handle form submission
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                              ),
                              child: const Text('Submit'),
                            ),
                          ],
                        ),
                      )
                    : ListTile(
                        leading: const Icon(Icons.email),
                        title: const Text('Contact Email'),
                        subtitle: Text(widget.guide.contactEmail),
                        trailing: Icon(
                          _isEmailFormExpanded
                              ? Icons.expand_less
                              : Icons.expand_more,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.facebook, color: Colors.blue),
                onPressed: () async {
                  if (await canLaunch(widget.guide.facebookUrl)) {
                    await launch(widget.guide.facebookUrl);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.camera_alt, color: Colors.pink),
                onPressed: () async {
                  if (await canLaunch(widget.guide.instagramUrl)) {
                    await launch(widget.guide.instagramUrl);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.play_circle_fill, color: Colors.red),
                onPressed: () async {
                  if (await canLaunch(widget.guide.youtubeUrl)) {
                    await launch(widget.guide.youtubeUrl);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
