import 'package:flutter/material.dart';
import '../models/tourist_spot.dart';

class SpotCard extends StatelessWidget {
  final TouristSpot spot;
  final VoidCallback? onTap;

  const SpotCard({required this.spot, this.onTap, super.key});

  @override
  Widget build(BuildContext c) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                spot.thumbnailUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                spot.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
