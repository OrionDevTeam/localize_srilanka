import 'package:flutter/material.dart';
import 'package:localize_sl/chat.dart';
import 'package:localize_sl/experience/experience_details.dart';
import 'package:localize_sl/get_started.dart';

const chatFeatureEnabled = false;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showDisabledFeatureDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('AI Travel Guide Chat Feature Disabled'),
          content: const Text(
            'Since the site is currently hosted in GitHub Pages, and due to the danger of exposing the OpenAI API key, the chat feature is disabled. Please run the app locally to enable the chat feature.',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Localize Sri Lanka',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const GetStartedPage(),
                ),
                (route) => false,
              );
            }, 
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!chatFeatureEnabled) {
            _showDisabledFeatureDialog(context);
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const ChatBotPage(),
            ),
          );
        },
        child: const Icon(Icons.support_agent),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search...',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(10),
                            ),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            color: Colors.grey[200],
                          ),
                          child: const Icon(Icons.search),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                        children: [
                          ExperienceCard(
                            title: 'Secret Waterfall',
                            imagePath: 'assets/vimosh/w1.jpg',
                            description: "This is a secret waterfall located in the middle of the forest. It's a great place to relax and enjoy the beauty of nature."
                          ),
                          ExperienceCard(
                            title: 'Ravana Waterfall',
                            imagePath: 'assets/vimosh/w2.jpg',
                            description: "This is a waterfall located in the middle of the forest. It's a great place to relax and enjoy the beauty of nature."
                          ),
                          ExperienceCard(
                            title: 'Nil Diya Pokuna',
                            imagePath: 'assets/vimosh/w3.jpg',
                            description: "This is a waterfall located in the middle of the forest. It's a great place to relax and enjoy the beauty of nature."
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: SizedBox(
              height: double.infinity,
              child: Container(
                margin: const EdgeInsets.only(left: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset(
                  'assets/vimosh/map.png',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExperienceCard extends StatelessWidget {
  const ExperienceCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.description,
  });

  final String title;
  final String imagePath;
  final String description;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ExperienceDetailsPage(
              heroTag: title,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          decoration: BoxDecoration(
            // border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                child: Hero(
                  tag: title,
                  child: Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.star_half_outlined,
                          color: Color.fromARGB(255, 234, 205, 40),
                        ),
                        const SizedBox(width: 5),
                        const Text(
                          '4.0',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Wrap(
                      spacing: 5,
                      children: [
                        Chip(
                          label: Text('Nature'),
                        ),
                        Chip(
                          label: Text('Adventure'),
                        ),
                        Chip(
                          label: Text('Waterfall'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

