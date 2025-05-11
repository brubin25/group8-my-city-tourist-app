import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📸 Hero banner
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/info/info.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
              const Icon(Icons.broken_image, size: 100),
            ),
          ),
          const SizedBox(height: 32),

          // 🔹 Section: About App
          Text(
            'Thunder Bay Tours',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Thunder Bay Tours is a modern travel companion designed to help visitors and locals explore the city\'s top attractions. '
                'Whether it\'s stunning nature trails, vibrant cultural sites, or winter activities, this app provides an intuitive and curated experience.',
            style: TextStyle(fontSize: 16, color: Colors.white70, height: 1.6),
          ),
          const SizedBox(height: 32),

          // 🔹 Section: App Details
          Text(
            'App Details',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow(label: 'Version', value: '1.0.0'),
          _buildInfoRow(label: 'Platform', value: 'Flutter (Cross-Platform)'),
          _buildInfoRow(label: 'Build Date', value: 'May 2025'),
          const SizedBox(height: 32),

          // 🔹 Section: Developed By
          Text(
            'Developed By',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Row(
              children: const [
                Icon(Icons.code, color: Colors.white70),
                SizedBox(width: 12),
                Text(
                  'Group 8 – Mobile Programming \n Computer Science Department',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }
}