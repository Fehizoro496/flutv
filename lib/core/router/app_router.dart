import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/categories/categories_screen.dart';
import '../../features/categories/category_detail_screen.dart';
import '../../features/favorites/favorites_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/player/player_args.dart';
import '../../features/player/player_screen.dart';
import '../../features/search/search_screen.dart';
import '../../shared/widgets/app_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => AppShell(
          location: state.matchedLocation,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/search',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: SearchScreen(),
            ),
          ),
          GoRoute(
            path: '/categories',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: CategoriesScreen(),
            ),
          ),
          GoRoute(
            path: '/favorites',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: FavoritesScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: '/category/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final label = state.extra is String ? state.extra as String : id;
          return CategoryDetailScreen(categoryId: id, label: label);
        },
      ),
      GoRoute(
        path: '/player/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          final args = state.extra is PlayerArgs ? state.extra as PlayerArgs : null;
          return PlayerScreen(
            channelId: id,
            initial: args?.view,
            heroTag: args?.heroTag,
          );
        },
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page introuvable : ${state.uri}'),
      ),
    ),
  );
});
