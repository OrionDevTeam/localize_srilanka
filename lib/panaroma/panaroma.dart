import 'package:flutter/material.dart';
import 'package:localize_sl/panaroma/widgets/panaroma.dart';

import 'widgets/card.dart';

class PanaromaScreen extends StatelessWidget {
  const PanaromaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          '360° Experiences',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ImageOverlayCard(
                title: 'Nine Arch Bridge',
                distance: '2.5 km',
                crowd: 'Spartially crowded',
                duration: '1 hour',
                imagePath: 'assets/vimosh/ella.jpg',
                overlayColor: Colors.black.withOpacity(0.5),
                onTap: () {
                  // Navigate to the new PanoramaViewerScreen and pass the image path
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PanoramaViewerScreen(
                          title: 'Ella', imagePath: 'assets/vimosh/pan1.jpg'),
                    ),
                  );
                },
              ),
              ImageOverlayCard(
                title: 'Ellawala Waterfall',
                distance: '2.5 km',
                crowd: 'crowded',
                duration: '1.2 hour',
                imagePath: 'assets/vimosh/waterfall.webp',
                overlayColor: Colors.black.withOpacity(0.5),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PanoramaViewerScreen(
                          title: 'Ella', imagePath: 'assets/vimosh/pan2.jpg'),
                    ),
                  );
                },
              ),
              ImageOverlayCard(
                title: 'Mirissa Beach',
                distance: '3.5 km',
                crowd: 'Spartially crowded',
                duration: '30 mins',
                imagePath: 'assets/vimosh/thalpe.jpg',
                overlayColor: Colors.black.withOpacity(0.5),
                onTap: () {
                  // Navigate to the new PanoramaViewerScreen and pass the image path
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PanoramaViewerScreen(
                          title: 'Ella', imagePath: 'assets/vimosh/pan2.jpg'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
