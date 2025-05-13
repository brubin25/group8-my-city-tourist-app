import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  final TextEditingController _feedbackController = TextEditingController();

  Future<void> _launchFeedback() async {
    final String feedback = _feedbackController.text.trim();
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@tbaytours.app',
      queryParameters: {
        'subject': 'Feedback: Thunder Bay Tours',
        'body': feedback.isEmpty ? 'Your feedback here...' : feedback,
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open email app')),
      );
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/info/info.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 100),
            ),
          ),
          const SizedBox(height: 32),

          Text(
            'Thunder Bay Tours',
            style: theme.textTheme.headlineMedium?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 12),
          const Text(
            'Thunder Bay Tours is a modern travel companion designed to help visitors and locals explore the city\'s top attractions. Whether it\'s stunning nature trails, vibrant cultural sites, or winter activities, this app provides an intuitive and curated experience.',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 32),

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

          Text(
            'Developed By',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          _buildTeamInfo(),

          const SizedBox(height: 32),

          Text(
            'Feedback',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),

          TextField(
            controller: _feedbackController,
            maxLines: 4,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Write your feedback here...',
              hintStyle: const TextStyle(color: Colors.white54),
              filled: true,
              fillColor: Colors.white10,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          Center(
            child: ElevatedButton.icon(
              onPressed: _launchFeedback,
              icon: const Icon(Icons.feedback, color: Colors.white),
              label: const Text(
                'Send Feedback',
                style: TextStyle(color: Colors.white),
              ),
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

  Widget _buildTeamInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: const ExpansionTile(
          iconColor: Colors.white70,
          collapsedIconColor: Colors.white70,
          title: Row(
            children: [
              Icon(Icons.code, color: Colors.white70),
              SizedBox(width: 12),
              Flexible(
                child: Text(
                  'Group 8 – Mobile Programming',
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('• Aesha', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Briand', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Chengrun', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Gulshan', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Kathan', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Omprakash', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Safira', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Vivek', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Yecheng', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Zhijie', style: TextStyle(color: Colors.white60)),
                  SizedBox(height: 4),
                  Text('• Zhiyuan', style: TextStyle(color: Colors.white60)),
                ],
              ),
            ),
          ],
        ),
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
            child: Text(value, style: const TextStyle(color: Colors.white60)),
          ),
        ],
      ),
    );
  }
}
