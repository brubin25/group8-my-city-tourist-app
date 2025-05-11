import 'package:flutter/material.dart';
import '../models/tourist_spot.dart';
import '../services/api_service.dart';
import '../widgets/spot_card.dart';
import 'spot_detail_screen.dart';
import 'gallery_screen.dart';
import 'info_screen.dart';

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
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Thunder Bay',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Explore the best spots',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.place),
              title: const Text('Spots'),
              onTap: () => _onDrawerItemTap(0),
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () => _onDrawerItemTap(1),
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Info'),
              onTap: () => _onDrawerItemTap(2),
            ),
          ],
        ),
      ),
      body: _getSelectedScreen(),
    );
  }
}