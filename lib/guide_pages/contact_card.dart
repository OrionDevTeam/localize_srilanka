import 'package:flutter/material.dart';

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ContactCard({
    super.key,
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
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(icon, size: 36.0),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14.0),
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

  const ContactSocialMediaCard({
    super.key,
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
          trailing: const Icon(Icons.share),
        ),
      ),
    );
  }
}
