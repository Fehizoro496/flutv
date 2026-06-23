import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../channels/data/models/channel_view.dart';
import '../channels/providers/channels_provider.dart';
import '../channels/widgets/channel_card.dart';
import '../player/player_args.dart';
import 'providers/favorites_provider.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = ref.watch(favoritesProvider);
    final channelsAsync = ref.watch(channelsProvider);
    final favorites = ref.watch(favoriteChannelsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Favoris')),
      body: switch ((ids.isEmpty, channelsAsync)) {
        (true, _) => const _EmptyState(),
        (_, AsyncLoading()) => const Center(child: CircularProgressIndicator()),
        _ => _FavoritesGrid(channels: favorites),
      },
    );
  }
}

class _FavoritesGrid extends StatelessWidget {
  const _FavoritesGrid({required this.channels});

  final List<ChannelView> channels;

  @override
  Widget build(BuildContext context) {
    if (channels.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Tes chaînes favorites ne sont pas encore chargées.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: channels.length,
      itemBuilder: (context, i) {
        final view = channels[i];
        final tag = 'fav-${view.id}';
        return ChannelCard(
          view: view,
          width: double.infinity,
          heroTag: tag,
          onTap: () => context.push(
            '/player/${view.id}',
            extra: PlayerArgs(view: view, heroTag: tag),
          ),
        );
      },
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_border_rounded,
                size: 40,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Aucun favori pour le moment',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Touche le cœur sur une chaîne pour la retrouver ici.',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.explore_rounded),
              label: const Text('Explorer les chaînes'),
            ),
          ],
        ),
      ),
    );
  }
}
