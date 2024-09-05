import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'guide_list_page.dart';
import 'guide_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Search Guides',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const GuidesList(),
    );
  }
}

class GuideListPage extends StatelessWidget {
  const GuideListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guides'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('guides').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: CircularProgressIndicator(color: Colors.green));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Guide guide = Guide.fromFirestore(doc);
              return GuideCard(guide: guide);
            }).toList(),
          );
        },
      ),
    );
  }
}
