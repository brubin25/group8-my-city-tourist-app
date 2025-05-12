import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) onItemSelected;

  const AppDrawer({super.key, required this.onItemSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/images/gallery/gallery2.jpg',
            fit: BoxFit.cover,
          ),

          // Dark overlay for readability
          Container(
            color: Colors.black.withOpacity(0.4),
          ),

          // Drawer content
          Column(
            children: [
              const DrawerHeader(
                margin: EdgeInsets.zero,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thunder Bay',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Explore the best spots',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildMenuItem(context, Icons.location_on_outlined, 'Spots', 0),
                    _buildMenuItem(context, Icons.image_outlined, 'Gallery', 1),
                    _buildMenuItem(context, Icons.info_outline_rounded, 'Info', 2),
                    _buildMenuItem(context, Icons.map_outlined, 'Map', 3),
                    _buildMenuItem(context, Icons.favorite_border, 'Favorites', 4),
                  ],
                ),
              ),
              const Divider(color: Colors.white70, thickness: 1),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildMenuItem(context, Icons.login_rounded, 'Login', 5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context,
      IconData icon,
      String label,
      int index,
      ) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
      onTap: () => onItemSelected(index),
      horizontalTitleGap: 8,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }
}