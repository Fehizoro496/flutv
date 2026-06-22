import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.child,
    required this.location,
  });

  final Widget child;
  final String location;

  static const _tabs = <_TabItem>[
    _TabItem(path: '/', icon: Icons.home_outlined, selectedIcon: Icons.home_rounded, label: 'Accueil'),
    _TabItem(path: '/search', icon: Icons.search, selectedIcon: Icons.search, label: 'Recherche'),
    _TabItem(path: '/categories', icon: Icons.grid_view_outlined, selectedIcon: Icons.grid_view_rounded, label: 'Catégories'),
    _TabItem(path: '/favorites', icon: Icons.favorite_outline, selectedIcon: Icons.favorite_rounded, label: 'Favoris'),
  ];

  int _indexFromLocation(String location) {
    for (var i = 0; i < _tabs.length; i++) {
      if (location == _tabs[i].path) return i;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final index = _indexFromLocation(location);
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => context.go(_tabs[i].path),
        destinations: [
          for (final tab in _tabs)
            NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.selectedIcon),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}

class _TabItem {
  const _TabItem({
    required this.path,
    required this.icon,
    required this.selectedIcon,
    required this.label,
  });

  final String path;
  final IconData icon;
  final IconData selectedIcon;
  final String label;
}
