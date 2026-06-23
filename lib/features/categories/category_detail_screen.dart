import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/async_value_view.dart';
import '../../shared/widgets/skeletons.dart';
import '../channels/data/models/channel_view.dart';
import '../channels/providers/channels_provider.dart';
import '../channels/widgets/channel_card.dart';
import '../player/player_args.dart';

class CategoryDetailScreen extends ConsumerWidget {
  const CategoryDetailScreen({
    super.key,
    required this.categoryId,
    required this.label,
  });

  final String categoryId;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channelsAsync = ref.watch(channelsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(label),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: AsyncValueView<List<ChannelView>>(
        value: channelsAsync,
        loadingBuilder: (_) => const GridSkeleton(),
        onRetry: () => ref.invalidate(channelsProvider),
        data: (_) {
          final channels = ref.watch(categoryChannelsProvider(categoryId));
          if (channels.isEmpty) {
            return Center(
              child: Text(
                'Aucune chaîne dans cette catégorie.',
                style: Theme.of(context).textTheme.bodyMedium,
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
              final tag = 'category-$categoryId-${view.id}';
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
        },
      ),
    );
  }
}
