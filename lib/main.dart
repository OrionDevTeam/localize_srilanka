import 'package:dart_openai/dart_openai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:localize_sl/screens/wrapper.dart';
import 'package:localize_sl/secrets.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

import 'services/auth.dart';

Future<void> main() async {
  OpenAI.apiKey = openaiApiKey;
  OpenAI.showLogs = false;
  OpenAI.showResponsesLogs = false;
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          home: Wrapper(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
