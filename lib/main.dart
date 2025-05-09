import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const ThunderBayToursApp());
}

class ThunderBayToursApp extends StatelessWidget {
  const ThunderBayToursApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thunder Bay Tours',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: const HomeScreen(),
    );
  }
}

/// Model for each tourist spot
class TouristSpot {
  final int id;
  final String title;
  final String synopsis;
  final String thumbnailUrl;

  // Driftscape thumbnails
  static const String _thumbBase = 'https://webapi.driftscape.com/document/id';
  static const String _thumbParams = '?Img=300&Crop=1:1;16:9;5:4&Contain';

  TouristSpot({
    required this.id,
    required this.title,
    required this.synopsis,
    required this.thumbnailUrl,
  });

  factory TouristSpot.fromJson(Map<String, dynamic> json) {
    final rawId = json['FEATURE_THUMBNAIL_URL'] as String;
    final fullUrl = '$_thumbBase/$rawId$_thumbParams';

    return TouristSpot(
      id: json['ID'] as int,
      title: json['FEATURE_TITLE'] as String,
      synopsis: json['FEATURE_SYNOPSIS'] as String? ?? '',
      thumbnailUrl: fullUrl,
    );
  }
}

class ApiService {
  static const _baseUrl = 'https://webapi.driftscape.com';
  static const _featureEP = '/feature';
  static const _apiKey = 'U0VNQW54WHJkdnVoUTUyMkIwRDNxdz09';

  static Future<List<TouristSpot>> fetchSpots() async {
    final uri = Uri.parse('$_baseUrl$_featureEP');

    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'limit': 30,
        'offset': 0,
        'sort_from': '[-89.27625905011959,48.46087567573946]',
        'id_list': null,
        'view': 'list',
        'filter': '',
        'layers': {'places': true, 'events': true, 'tours': true},
        'username': '',
        'key': _apiKey,
        'referrer': 'webapp.driftscape.com',
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load spots (${response.statusCode})');
    }

    final Map<String, dynamic> data = jsonDecode(response.body);
    final rows = (data['rows'] as List).cast<Map<String, dynamic>>();
    return rows.map((r) => TouristSpot.fromJson(r)).toList();
  }
}

// Home Screen showing spots
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thunder Bay Tours')),
      body: FutureBuilder<List<TouristSpot>>(
        future: ApiService.fetchSpots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final spots = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: spots.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, i) {
              final spot = spots[i];
              return Card(
                elevation: 3,
                clipBehavior: Clip.hardEdge,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.network(
                        spot.thumbnailUrl,
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) =>
                                const Center(child: Icon(Icons.broken_image)),
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
              );
            },
          );
        },
      ),
    );
  }
}
