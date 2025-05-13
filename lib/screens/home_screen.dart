import 'package:flutter/material.dart';
import '../models/tourist_spot.dart';
import '../services/api_service.dart';
import '../widgets/spot_card.dart';
import 'spot_detail_screen.dart';
import 'gallery_screen.dart';
import 'info_screen.dart';
import 'login_screen.dart';
import 'map_screen.dart';
import '../widgets/app_drawer.dart';
import 'favorites_screen.dart';


class HomeScreen extends StatefulWidget {
  final void Function(Locale)? onLocaleChange;

  const HomeScreen({super.key, this.onLocaleChange});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late Future<List<TouristSpot>> _futureSpots;
  final _api = ApiService();
  int _selectedDrawerIndex = 0;
  Set<TouristSpot> _favorites = {};

  @override
  void initState() {
    super.initState();
    _futureSpots = _api.fetchSpots();
  }

  void _toggleFavorite(TouristSpot spot) {
    setState(() {
      if (_favorites.contains(spot)) {
        _favorites.remove(spot);
      } else {
        _favorites.add(spot);
      }
    });
  }

  Widget _buildSpotGrid(List<TouristSpot> spots) {
    const itemHeight = 250.0;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width - 16;
    final aspectRatio = screenWidth / itemHeight;

    return GridView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: spots.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: aspectRatio,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, i) {
        final spot = spots[i];
        final isFavorite = _favorites.contains(spot);
        return Stack(
          children: [
            SpotCard(
              spot: spot,
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: const Duration(milliseconds: 600),
                    reverseTransitionDuration: const Duration(
                        milliseconds: 600),
                    pageBuilder: (_, __, ___) => SpotDetailScreen(spot: spot),
                    transitionsBuilder: (context, animation, _, child) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                  ),
                );
              },
            ),
            Positioned(
              top: 8,
              right: 8,
              child: IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.redAccent : Colors.white,
                  size: 24,
                ),
                onPressed: () => _toggleFavorite(spot),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSpotsView() {
    return FutureBuilder<List<TouristSpot>>(
      future: _futureSpots,
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        }
        return _buildSpotGrid(snap.data!);
      },
    );
  }

  Widget _buildFavoritesView() {
    final spots = _favorites.toList();
    if (spots.isEmpty) {
      return const Center(
        child: Text(
            'No favorites added yet', style: TextStyle(color: Colors.white70)),
      );
    }
    return _buildSpotGrid(spots);
  }

  Widget _getSelectedScreen() {
    switch (_selectedDrawerIndex) {
      case 0:
        return _buildSpotsView();
      case 1:
        return const GalleryScreen();
      case 2:
        return FavoritesScreen(favorites: _favorites.toList());
      case 3:
        return const MapScreen();
      case 4:
        return const InfoScreen();
      case 5:
        return const LoginScreen();
      default:
        return _buildSpotsView();
    }
  }

  void _onDrawerItemTap(int index) {
    Navigator.of(context).pop(); // Close drawer

    if (index == 5) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
    } else {
      setState(() {
        _selectedDrawerIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF5B247A), // rich purple
            Color(0xFF1B1A4F), // deep indigo
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Thunder Bay Tours'),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        drawer: AppDrawer(
          onItemSelected: _onDrawerItemTap,
          onLanguageChanged: widget.onLocaleChange ?? (_) {},
        ),
        body: _getSelectedScreen(),
      ),
    );
  }
}