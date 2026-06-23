import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/widgets/async_value_view.dart';
import '../channels/data/models/channel_view.dart';
import '../channels/providers/channels_provider.dart';
import 'data/models/epg_programme.dart';
import 'providers/epg_provider.dart';

class EpgScreen extends ConsumerWidget {
  const EpgScreen({super.key, required this.channelId});

  final String channelId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final channel = ref.watch(channelByIdProvider(channelId));
    final programmesAsync = ref.watch(programmesProvider(channelId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(channel?.name ?? 'Programme TV'),
      ),
      body: AsyncValueView<List<EpgProgramme>>(
        value: programmesAsync,
        loadingMessage: 'Chargement du programme…',
        onRetry: () => ref.invalidate(programmesProvider(channelId)),
        data: (list) => _ProgrammesList(programmes: list, channel: channel),
      ),
    );
  }
}

class _ProgrammesList extends StatelessWidget {
  const _ProgrammesList({required this.programmes, required this.channel});

  final List<EpgProgramme> programmes;
  final ChannelView? channel;

  @override
  Widget build(BuildContext context) {
    if (programmes.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.event_busy_rounded,
                size: 48,
                color: AppColors.textMuted,
              ),
              const SizedBox(height: 16),
              Text(
                'Aucun programme pour le moment',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'iptv-org publie un index sans URLs XMLTV directement '
                'utilisables. Ajoute une source dans '
                '`epgManualXmltvUrls` (lib/features/epg/data/epg_overrides.dart) '
                'pour activer le guide.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      );
    }
    final now = DateTime.now();
    final currentIndex = programmes.indexWhere((p) => p.isLiveAt(now));
    final scrollIndex = currentIndex >= 0 ? currentIndex : 0;

    return ListView.separated(
      controller: ScrollController(
        initialScrollOffset: scrollIndex * 88.0,
      ),
      padding: const EdgeInsets.all(16),
      itemCount: programmes.length,
      separatorBuilder: (_, _) => const SizedBox(height: 8),
      itemBuilder: (context, i) {
        final p = programmes[i];
        final live = p.isLiveAt(now);
        return _ProgrammeTile(programme: p, live: live);
      },
    );
  }
}

class _ProgrammeTile extends StatelessWidget {
  const _ProgrammeTile({required this.programme, required this.live});

  final EpgProgramme programme;
  final bool live;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: live
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: live ? AppColors.primary : AppColors.border,
          width: live ? 1.4 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatTime(programme.start),
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: live ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDuration(programme.duration),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (live) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.liveIndicator,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          'EN COURS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        programme.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                  ],
                ),
                if (programme.description != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    programme.description!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  String _formatDuration(Duration d) {
    final h = d.inHours;
    final m = d.inMinutes.remainder(60);
    if (h == 0) return '${m}min';
    if (m == 0) return '${h}h';
    return '${h}h${m.toString().padLeft(2, '0')}';
  }
}
