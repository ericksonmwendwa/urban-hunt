import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:urban_hunt/screens/favorites_screen.dart';
import 'package:urban_hunt/screens/home_screen.dart';
import 'package:urban_hunt/screens/map_screen.dart';
import 'package:urban_hunt/screens/profile_screen.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _selectedIndex = 0;

  final List<String> _titles = <String>['Home', 'Map', 'Favorites', 'Profile'];

  final List<Widget> _screens = <Widget>[
    const HomeScreen(),
    const MapScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_titles[_selectedIndex])),
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Widget _bottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: GNav(
          selectedIndex: _selectedIndex,
          onTabChange: (int index) {
            setState(() => _selectedIndex = index);
          },
          tabs: <GButton>[
            GButton(icon: Icons.home_rounded, text: 'Home'),
            GButton(icon: Icons.map_rounded, text: 'Map'),
            GButton(icon: Icons.favorite_rounded, text: 'Favorites'),
            GButton(icon: Icons.person_rounded, text: 'Profile'),
          ],
          gap: 8,
          textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.surface,
          ),
          color: Theme.of(context).disabledColor,
          activeColor: Theme.of(context).colorScheme.surface,
          backgroundColor: Theme.of(context).colorScheme.surface,
          tabBackgroundColor: Theme.of(context).primaryColor,
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
          duration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}
