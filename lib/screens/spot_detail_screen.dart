// lib/screens/spot_detail_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import '../models/tourist_spot.dart';

class SpotDetailScreen extends StatelessWidget {
  final TouristSpot spot;
  const SpotDetailScreen({Key? key, required this.spot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(spot.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Hero’d thumbnail
            Hero(
              tag: spot.thumbnailUrl,
              transitionOnUserGestures: true,
              child: Image.network(
                spot.thumbnailUrl,
                fit: BoxFit.cover,
                height: 240,
                errorBuilder:
                    (_, __, ___) => const SizedBox(
                      height: 240,
                      child: Center(child: Icon(Icons.broken_image, size: 48)),
                    ),
              ),
            ),

            // Title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                spot.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            // HTML description
            if (spot.synopsis.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Html(
                  data: spot.synopsis,
                  style: {
                    // use Margins not EdgeInsets here:
                    "p": Style(margin: Margins.symmetric(vertical: 8)),
                    // you can style other tags similarly if you want
                  },
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
