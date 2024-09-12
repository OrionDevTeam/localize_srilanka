import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class PanaromaScreen extends StatelessWidget {
  const PanaromaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panaroma'),
      ),
      body: PanoramaViewer(
        child: Image.asset('assets/visa/p2.jpg'),
      ),
    );
  }
}
