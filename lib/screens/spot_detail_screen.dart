import 'package:flutter/material.dart';
import '../models/tourist_spot.dart';

class SpotDetailScreen extends StatelessWidget {
  final TouristSpot spot;
  const SpotDetailScreen({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(spot.title)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // thumbnail
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
            // title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                spot.title,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),

            // description
            if (spot.synopsis.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  spot.synopsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
