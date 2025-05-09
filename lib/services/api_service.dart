import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tourist_spot.dart';

class ApiService {
  static const _baseUrl = 'https://webapi.driftscape.com';
  static const _featureEP = '/feature';
  static const _apiKey = 'U0VNQW54WHJkdnVoUTUyMkIwRDNxdz09';

  Future<List<TouristSpot>> fetchSpots({
    int limit = 30,
    int offset = 0,
    String sortFrom = '[-89.27625905011959,48.46087567573946]',
  }) async {
    final uri = Uri.parse('$_baseUrl$_featureEP');
    final body = jsonEncode({
      'limit': limit,
      'offset': offset,
      'sort_from': sortFrom,
      'id_list': null,
      'view': 'list',
      'filter': '',
      'layers': {'places': true, 'events': true, 'tours': true},
      'username': '',
      'key': _apiKey,
      'referrer': 'webapp.driftscape.com',
    });

    final resp = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (resp.statusCode != 200) {
      throw Exception('API error: ${resp.statusCode}');
    }

    final jsonMap = jsonDecode(resp.body) as Map<String, dynamic>;
    final rows = (jsonMap['rows'] as List).cast<Map<String, dynamic>>();
    return rows.map(TouristSpot.fromJson).toList();
  }
}
