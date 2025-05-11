import 'package:flutter/material.dart';
import '../models/tourist_spot.dart';
import '../services/api_service.dart';
import '../widgets/spot_card.dart';
import 'spot_detail_screen.dart';
import 'gallery_screen.dart';
import 'info_screen.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<TouristSpot>> _futureSpots;
  final _api = ApiService();
  int _selectedDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    _futureSpots = _api.fetchSpots();
  }

  Widget _buildSpotsView() {
    const itemHeight = 250.0;
    final screenWidth = MediaQuery.of(context).size.width - 16;
    final aspectRatio = screenWidth / itemHeight;

    return FutureBuilder<List<TouristSpot>>(
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
                    reverseTransitionDuration: const Duration(milliseconds: 600),
                    pageBuilder: (_, __, ___) => SpotDetailScreen(spot: spot),
                    transitionsBuilder: (context, animation, _, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _getSelectedScreen() {
    switch (_selectedDrawerIndex) {
      case 0:
        return _buildSpotsView();
      case 1:
        return const GalleryScreen();
      case 2:
        return const InfoScreen();
      default:
        return _buildSpotsView();
    }
  }

  void _onDrawerItemTap(int index) {
    Navigator.of(context).pop(); // Close the drawer
    setState(() {
      _selectedDrawerIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: const Text('Thunder Bay Tours'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawer: AppDrawer(onItemSelected: _onDrawerItemTap),
      body: _getSelectedScreen(),
    );
  }
}