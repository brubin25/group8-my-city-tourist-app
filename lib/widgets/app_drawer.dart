import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppDrawer extends StatelessWidget {
  final Function(int) onItemSelected;
  final Function(Locale) onLanguageChanged;

  const AppDrawer({
    super.key,
    required this.onItemSelected,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Drawer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/gallery/gallery2.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.4)),
          Column(
            children: [
              DrawerHeader(
                margin: EdgeInsets.zero,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.appTitle,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      loc.explore,
                      style: const TextStyle(
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
                    _buildMenuItem(context, Icons.location_on_outlined, loc.spots, 0),
                    _buildMenuItem(context, Icons.image_outlined, loc.gallery, 1),
                    _buildMenuItem(context, Icons.favorite_border, loc.favorites, 2),
                    _buildMenuItem(context, Icons.map_outlined, loc.map, 3),
                    _buildMenuItem(context, Icons.info_outline_rounded, loc.info, 4),
                    _buildLanguageItem(context, loc),
                  ],
                ),
              ),
              const Divider(color: Colors.white70),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildMenuItem(context, Icons.login_rounded, loc.login, 5),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      BuildContext context, IconData icon, String label, int index) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        label,
        style: const TextStyle(fontSize: 16, color: Colors.white),
      ),
      onTap: () => onItemSelected(index),
      horizontalTitleGap: 8,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    );
  }

  Widget _buildLanguageItem(BuildContext context, AppLocalizations loc) {
    return ListTile(
      leading: const Icon(Icons.language, color: Colors.white),
      title: Text(loc.language, style: const TextStyle(color: Colors.white)),
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(loc.chooseLanguage),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(loc.english),
                  onTap: () {
                    onLanguageChanged(const Locale('en'));
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(loc.french),
                  onTap: () {
                    onLanguageChanged(const Locale('fr'));
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}