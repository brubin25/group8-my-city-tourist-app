import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'About Thunder Bay Tours',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Discover the beauty and heritage of Thunder Bay with our curated selection of the city\'s best attractions. Whether you love nature, history, or culture, there\'s something for everyone.',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          SizedBox(height: 24),
          Text(
            'App Version: 1.0.0',
            style: TextStyle(fontSize: 14, color: Colors.white38),
          ),
        ],
      ),
    );
  }
}