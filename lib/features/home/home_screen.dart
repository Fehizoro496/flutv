import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/async_value_view.dart';
import '../channels/data/models/channel_view.dart';
import '../channels/providers/channels_provider.dart';
import '../channels/widgets/category_rail.dart';
import '../channels/widgets/featured_carousel.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channels = ref.watch(channelsProvider);

    return RefreshIndicator(
      onRefresh: () => refreshChannels(ref),
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            floating: true,
            title: const Text('Flutv'),
            actions: [
              IconButton(
                icon: const Icon(Icons.search_rounded),
                onPressed: () => context.push('/search'),
              ),
              IconButton(
                icon: const Icon(Icons.refresh_rounded),
                onPressed: () => refreshChannels(ref),
              ),
              const SizedBox(width: 4),
            ],
          ),
          SliverFillRemaining(
            hasScrollBody: true,
            child: AsyncValueView<List<ChannelView>>(
              value: channels,
              loadingMessage: 'Chargement des chaînes françaises…',
              onRetry: () => ref.invalidate(channelsProvider),
              data: (_) => const _HomeContent(),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeContent extends ConsumerWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featured = ref.watch(featuredChannelsProvider);
    final rails = ref.watch(homeRailsProvider);

    if (featured.isEmpty && rails.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Aucune chaîne française disponible pour le moment.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 32),
      children: [
        if (featured.isNotEmpty) ...[
          const SizedBox(height: 8),
          FeaturedCarousel(channels: featured),
        ],
        for (final rail in rails)
          CategoryRail(
            title: rail.label,
            channels: rail.channels,
            heroPrefix: 'rail-${rail.categoryId}',
            onSeeAll: () => context.push(
              '/category/${rail.categoryId}',
              extra: rail.label,
            ),
          ),
      ],
    );
  }
}
