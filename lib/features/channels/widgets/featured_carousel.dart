import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../player/player_args.dart';
import '../data/models/channel_view.dart';

class FeaturedCarousel extends StatefulWidget {
  const FeaturedCarousel({
    super.key,
    required this.channels,
    this.height = 200,
    this.interval = const Duration(seconds: 4),
  });

  final List<ChannelView> channels;
  final double height;
  final Duration interval;

  @override
  State<FeaturedCarousel> createState() => _FeaturedCarouselState();
}

class _FeaturedCarouselState extends State<FeaturedCarousel> {
  late final PageController _controller;
  Timer? _timer;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(viewportFraction: 0.88);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    if (widget.channels.length <= 1) return;
    _timer = Timer.periodic(widget.interval, (_) {
      if (!mounted || !_controller.hasClients) return;
      final next = (_index + 1) % widget.channels.length;
      _controller.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.channels.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      height: widget.height + 20,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notif) {
          if (notif is ScrollStartNotification) {
            _timer?.cancel();
          } else if (notif is ScrollEndNotification) {
            _startTimer();
          }
          return false;
        },
        child: PageView.builder(
          controller: _controller,
          onPageChanged: (i) => setState(() => _index = i),
          itemCount: widget.channels.length,
          itemBuilder: (context, i) {
            final view = widget.channels[i];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: _FeaturedCard(view: view),
            );
          },
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.view});

  final ChannelView view;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      borderRadius: BorderRadius.circular(24),
      color: AppColors.surface,
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.push(
          '/player/${view.id}',
          extra: PlayerArgs(view: view, heroTag: 'featured-${view.id}'),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primary.withValues(alpha: 0.92),
                AppColors.primaryDark,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.25),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Hero(
                tag: 'featured-${view.id}',
                child: _LogoTile(url: view.logo, name: view.name),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const _LiveBadge(),
                    const SizedBox(height: 12),
                    Text(
                      view.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    if (view.categories.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        view.categories.take(2).join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.play_circle_fill_rounded,
                          color: Colors.white.withValues(alpha: 0.95),
                          size: 22,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Regarder',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoTile extends StatelessWidget {
  const _LogoTile({required this.url, required this.name});

  final String? url;
  final String name;

  @override
  Widget build(BuildContext context) {
    const size = 88.0;
    final fallback = Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        name.characters.first.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 32,
        ),
      ),
    );
    if (url == null || url!.isEmpty) return fallback;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: size,
        height: size,
        color: Colors.white,
        padding: const EdgeInsets.all(8),
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

class _LiveBadge extends StatelessWidget {
  const _LiveBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.liveIndicator,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.fiber_manual_record, size: 10, color: Colors.white),
          SizedBox(width: 4),
          Text(
            'EN DIRECT',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
