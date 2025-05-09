import 'package:flutter/material.dart';
import '../models/tourist_spot.dart';
import '../services/api_service.dart';
import '../widgets/spot_card.dart';
import 'spot_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<TouristSpot>> _futureSpots;
  final _api = ApiService();

  @override
  void initState() {
    super.initState();
    _futureSpots = _api.fetchSpots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Thunder Bay Tours')),
      body: FutureBuilder<List<TouristSpot>>(
        future: _futureSpots,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Error: ${snap.error}'));
          }
          final spots = snap.data!;
          return GridView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: spots.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder:
                (_, i) => SpotCard(
                  spot: spots[i],
                  // navigate to a detail screen
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SpotDetailScreen(spot: spots[i]),
                      ),
                    );
                  },
                ),
          );
        },
      ),
    );
  }
}
