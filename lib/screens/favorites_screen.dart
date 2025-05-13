import 'package:flutter/material.dart';
import '../models/tourist_spot.dart';
import '../widgets/spot_card.dart';
import 'spot_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  final List<TouristSpot> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    const itemHeight = 250.0;
    final screenWidth = MediaQuery.of(context).size.width - 16;
    final aspectRatio = screenWidth / itemHeight;

    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          'No favorites added yet.',
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: favorites.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, i) {
        final spot = favorites[i];
        return SpotCard(
          spot: spot,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SpotDetailScreen(spot: spot),
              ),
            );
          },
        );
      },
    );
  }
}