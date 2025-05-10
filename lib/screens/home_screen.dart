import 'package:flutter/material.dart';
import '../models/tourist_spot.dart';
import '../services/api_service.dart';
import '../widgets/spot_card.dart';
import 'spot_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<TouristSpot>> _futureSpots;
  final _api = ApiService();

  @override
  void initState() {
    super.initState();
    _futureSpots = _api.fetchSpots();
  }

  @override
  Widget build(BuildContext context) {
    const itemHeight = 250.0;
    final screenWidth = MediaQuery.of(context).size.width - 16;
    final aspectRatio = screenWidth / itemHeight;

    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text('Thunder Bay Tours'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
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
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: aspectRatio,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, i) {
              final spot = spots[i];
              return SpotCard(
                spot: spot,
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      transitionDuration: const Duration(milliseconds: 600),
                      reverseTransitionDuration: const Duration(
                        milliseconds: 600,
                      ),
                      pageBuilder: (_, __, ___) => SpotDetailScreen(spot: spot),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
