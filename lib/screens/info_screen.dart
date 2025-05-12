// info_screen.dart

import 'package:flutter/material.dart';
// import for launching email feedback
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  // Email feedback launcher
  static Future<void> _launchFeedback() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@tbaytours.app',
      queryParameters: {
        'subject': 'Feedback: Thunder Bay Tours',
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Could not launch $emailUri');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero banner
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

          // Section: About App
          Text(
            'Thunder Bay Tours',
            style: theme.textTheme.headlineMedium
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            'Thunder Bay Tours is a modern travel companion designed to help visitors and locals explore the city\'s top attractions. Whether it\'s stunning nature trails, vibrant cultural sites, or winter activities, this app provides an intuitive and curated experience.',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 32),

          // Section: App Details
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

          // Expandable team roster
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white12),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                iconColor: Colors.white70,
                collapsedIconColor: Colors.white70,
                title: Row(
                  children: const [
                    Icon(Icons.code, color: Colors.white70),
                    SizedBox(width: 12),
                    Text(
                      'Group 8 – Mobile Programming',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ],
                ),
                // Team members list
                childrenPadding: const EdgeInsets.only(left: 48, bottom: 8),
                children: const [
                  Text('• Chengrun, Yecheng, Zhiyuan – Home Screen',
                      style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Kathan, Vivek – Map Screen',
                      style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Gulshan, Omprakash – Tourist Spot Details Screen',
                      style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Briand, Zhijie – Gallery + About/Info Screen',
                      style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Aesha, Safira – Favorites/Bookmarks + Search/Filter',
                      style: TextStyle(color: Colors.white60)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),

          // Feedback Button Section
          Center(
            child: ElevatedButton.icon(
              onPressed: _launchFeedback,
              icon: const Icon(Icons.feedback, color: Colors.white),
              label: const Text('Send Feedback',
                  style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white24,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(color: Colors.white70)),
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
