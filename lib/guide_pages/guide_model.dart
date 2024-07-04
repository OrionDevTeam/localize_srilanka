import 'package:cloud_firestore/cloud_firestore.dart';

class Guide {
  final String name;
  final List<String> languages;
  final double rating;
  final int reviews;
  final String description;
  final String bio;
  final List<String> tags;
  final List<Map<String, dynamic>> packages;
  final List<Map<String, dynamic>> experiences;
  final List<Map<String, dynamic>> services;
  final String documentId;
  final String contactNumber;
  final String contactEmail;
  final String facebookUrl;
  final String instagramUrl;
  final String youtubeUrl;
  final String telegramUrl;
  final String whatsappUrl;
  final String username;
  final String profileImageUrl;
  final String Average_hourly_rate;

  Guide({
    required this.name,
    required this.languages,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.bio,
    required this.tags,
    required this.packages,
    required this.experiences,
    required this.services,
    required this.documentId,
    required this.contactNumber,
    required this.contactEmail,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.youtubeUrl,
    required this.telegramUrl,
    required this.whatsappUrl,
    required this.username,
    required this.profileImageUrl,
    required this.Average_hourly_rate,
  });

  factory Guide.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    return Guide(
      name: data['name'] ?? '',
      languages: List<String>.from(data['languages'] ?? []),
      rating: (data['rating'] ?? 0.0).toDouble(),
      reviews: data['reviews'] ?? 0,
      description: data['description'] ?? '',
      bio: data['bio'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      profileImageUrl: data['profileImageUrl'] ?? '',
      packages: List<Map<String, dynamic>>.from(data['packages'] ?? []),
      experiences: List<Map<String, dynamic>>.from(data['experiences'] ?? []),
      services: List<Map<String, dynamic>>.from(data['services'] ?? []),
      documentId: data['documentId'] ?? '',
      contactNumber: data['contactNumber'] ?? '',
      contactEmail: data['contactEmail'] ?? '',
      facebookUrl: data['facebookUrl'] ?? '',
      instagramUrl: data['instagramUrl'] ?? '',
      youtubeUrl: data['youtubeUrl'] ?? '',
      telegramUrl: data['telegramUrl'] ?? '',
      whatsappUrl: data['whatsappUrl'] ?? '',
      username: data['username'] ?? '',
      Average_hourly_rate: data['Average_hourly_rate'] ?? '',
    );
  }
}
