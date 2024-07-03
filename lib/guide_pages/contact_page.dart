import 'package:flutter/material.dart';
import 'guide_model.dart';
import 'contact_card.dart';


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