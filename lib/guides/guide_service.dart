import 'package:cloud_firestore/cloud_firestore.dart';
import 'guide_model.dart';


class GuideService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Guide>> fetchGuides() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await _db.collection('guides').get();
    print('Fetched ${snapshot.docs.length} guides'); // Add this line
    return snapshot.docs.map((doc) => Guide.fromFirestore(doc)).toList();
  }
}



Future<String> getProfilePictureUrl(String guideId) async {
  try {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(guideId)
        .get();

    if (userDoc.exists) {
      final profileImageUrl = userDoc.get('profileImageUrl');
      print('Fetched profile picture URL: $profileImageUrl');
      return profileImageUrl;
    } else {
      print('Document does not exist for guideId: $guideId');
      return '';
    }
  } catch (e) {
    print('Error fetching profile picture URL: $e');
    return '';
  }
}
