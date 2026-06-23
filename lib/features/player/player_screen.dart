import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../channels/data/models/channel_view.dart';
import '../channels/providers/channels_provider.dart';

class PlayerScreen extends ConsumerWidget {
  const PlayerScreen({
    super.key,
    required this.channelId,
    this.initial,
    this.heroTag,
  });

  final String channelId;
  final ChannelView? initial;
  final String? heroTag;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final view = initial ?? ref.watch(channelByIdProvider(channelId));

    Widget logo = _PlayerLogo(url: view?.logo, name: view?.name ?? 'Chaîne');
    if (heroTag != null && view != null) {
      logo = Hero(tag: heroTag!, child: logo);
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(view?.name ?? 'Chaîne'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              alignment: Alignment.center,
              child: view == null
                  ? const CircularProgressIndicator()
                  : SizedBox(width: 140, height: 140, child: logo),
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Le lecteur arrivera en Phase 4.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerLogo extends StatelessWidget {
  const _PlayerLogo({required this.url, required this.name});

  final String? url;
  final String name;

  @override
  Widget build(BuildContext context) {
    final fallback = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Text(
        name.characters.first.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 56,
        ),
      ),
    );
    if (url == null || url!.isEmpty) return fallback;
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(14),
        child: CachedNetworkImage(
          imageUrl: url!,
          fit: BoxFit.contain,
          placeholder: (_, _) => const SizedBox.shrink(),
          errorWidget: (_, _, _) => fallback,
        ),
      ),
    );
  }
}
