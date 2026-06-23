import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../player/player_args.dart';
import '../data/models/channel_view.dart';
import 'channel_card.dart';

class CategoryRail extends StatelessWidget {
  const CategoryRail({
    super.key,
    required this.title,
    required this.channels,
    required this.heroPrefix,
    this.onSeeAll,
  });

  final String title;
  final List<ChannelView> channels;
  final String heroPrefix;
  final VoidCallback? onSeeAll;

  @override
  Widget build(BuildContext context) {
    if (channels.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 12, 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                if (onSeeAll != null)
                  TextButton(
                    onPressed: onSeeAll,
                    child: const Text('Tout voir'),
                  ),
              ],
            ),
          ),
          SizedBox(
            height: 168,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: channels.length,
              separatorBuilder: (_, _) => const SizedBox(width: 12),
              itemBuilder: (context, i) {
                final view = channels[i];
                final tag = '$heroPrefix-${view.id}';
                return ChannelCard(
                  view: view,
                  heroTag: tag,
                  onTap: () => context.push(
                    '/player/${view.id}',
                    extra: PlayerArgs(view: view, heroTag: tag),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
