import 'package:cloud_firestore/cloud_firestore.dart';


class Guide {
  final String id;
  final String name;
  final String profilePictureUrl;
  final int age;
  final String address;
  final List<String> languages;
  final double rating;
  final int reviews;
  final String description;
  final List<String> tags;
  final String about;
  final List<String> experiences;
  final String contactNumber;
  final String contactEmail;
  final List<Map<String, dynamic>> packages;
  final String facebookUrl;
  final String instagramUrl;
  final String youtubeUrl;

  Guide({
    required this.id,
    required this.name,
    required this.profilePictureUrl,
    required this.age,
    required this.address,
    required this.languages,
    required this.rating,
    required this.reviews,
    required this.description,
    required this.tags,
    required this.about,
    required this.experiences,
    required this.contactNumber,
    required this.contactEmail,
    required this.packages,
    required this.facebookUrl,
    required this.instagramUrl,
    required this.youtubeUrl,
  });

  factory Guide.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic> data = doc.data()!;
    
    return Guide(
      id: doc.id,
      name: data['name'] ?? '',
      profilePictureUrl: data['profilePictureUrl'] ?? '',
      age: data['age'] ?? 0,
      address: data['address'] ?? '',
      languages: data['languages'] != null ? List<String>.from(data['languages']) : [],
      rating: (data['rating'] ?? 0).toDouble(),
      reviews: data['reviews'] ?? 0,
      description: data['description'] ?? '',
      tags: data['tags'] != null ? List<String>.from(data['tags']) : [],
      about: data['about'],
      experiences: List<String>.from(data['experiences']),
      contactNumber: data['contactNumber'] ?? '',
      contactEmail: data['contactEmail'] ?? '',
      packages: List<Map<String, dynamic>>.from(data['packages']),
      facebookUrl: data['facebookUrl'] ?? '',
      instagramUrl: data['instagramUrl'] ?? '',
      youtubeUrl: data['youtubeUrl'] ?? '',
    );
  }
}
