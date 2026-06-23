import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../shared/widgets/async_value_view.dart';
import '../../shared/widgets/skeletons.dart';
import '../channels/data/models/channel_view.dart';
import '../channels/providers/channels_provider.dart';
import '../channels/widgets/channel_card.dart';
import '../player/player_args.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _controller.text = ref.read(searchQueryProvider);
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      ref.read(searchQueryProvider.notifier).state = value;
    });
  }

  void _clear() {
    _controller.clear();
    _debounce?.cancel();
    ref.read(searchQueryProvider.notifier).state = '';
  }

  @override
  Widget build(BuildContext context) {
    final channelsAsync = ref.watch(channelsProvider);
    final query = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controller,
          autofocus: true,
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            hintText: 'Rechercher une chaîne…',
            border: InputBorder.none,
            suffixIcon: query.isEmpty
                ? const Icon(Icons.search_rounded)
                : IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: _clear,
                  ),
          ),
          onChanged: _onChanged,
        ),
      ),
      body: AsyncValueView<List<ChannelView>>(
        value: channelsAsync,
        loadingBuilder: (_) => const GridSkeleton(),
        onRetry: () => ref.invalidate(channelsProvider),
        data: (_) {
          final results = ref.watch(searchResultsProvider);
          if (query.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  'Tape le nom d\'une chaîne pour démarrer.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          }
          if (results.isEmpty) {
            return Center(
              child: Text(
                'Aucun résultat pour « $query ».',
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
            itemCount: results.length,
            itemBuilder: (context, i) {
              final view = results[i];
              final tag = 'search-${view.id}';
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
