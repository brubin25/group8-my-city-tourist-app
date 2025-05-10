import 'package:city_tourist_app/widgets/parallax_delegate.dart';
// lib/widgets/spot_card.dart

import 'package:flutter/material.dart';

import '../models/tourist_spot.dart';

/// A card widget that displays a tourist spot with a parallax background, gradient overlay, and title.
class SpotCard extends StatelessWidget {
  final TouristSpot spot;
  final VoidCallback? onTap;
  final GlobalKey _backgroundImageKey;

  SpotCard({Key? key, required this.spot, this.onTap})
    : _backgroundImageKey = GlobalKey(),
      super(key: key);

  Widget _buildImage(BuildContext context) {
    return Flow(
      delegate: ParallaxFlowDelegate(
        scrollable: Scrollable.of(context),
        listItemContext: context,
        backgroundImageKey: _backgroundImageKey,
      ),
      children: [
        Hero(
          tag: spot.thumbnailUrl,
          child: Image.network(
            spot.thumbnailUrl,
            fit: BoxFit.cover,
            key: _backgroundImageKey,
            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
          ),
        ),
      ],
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withValues(alpha: 0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Text(
        spot.title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        color: Colors.white,
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: [_buildImage(context), _buildGradient(), _buildTitle()],
        ),
      ),
    );
  }
}
