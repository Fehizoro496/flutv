import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../favorites/providers/favorites_provider.dart';
import '../data/models/channel_view.dart';

class ChannelCard extends ConsumerStatefulWidget {
  const ChannelCard({
    super.key,
    required this.view,
    required this.onTap,
    this.width = 112,
    this.heroTag,
    this.showFavorite = true,
  });

  final ChannelView view;
  final VoidCallback onTap;
  final double width;
  final String? heroTag;
  final bool showFavorite;

  @override
  ConsumerState<ChannelCard> createState() => _ChannelCardState();
}

class _ChannelCardState extends ConsumerState<ChannelCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isFav = widget.showFavorite
        ? ref.watch(isFavoriteProvider(widget.view.id))
        : false;

    Widget logoBox = AspectRatio(
      aspectRatio: 1,
      child: _LogoSquare(url: widget.view.logo, name: widget.view.name),
    );
    if (widget.heroTag != null) {
      logoBox = Hero(tag: widget.heroTag!, child: logoBox);
    }
    if (widget.showFavorite) {
      logoBox = Stack(
        children: [
          logoBox,
          Positioned(
            top: 6,
            right: 6,
            child: _HeartButton(
              active: isFav,
              onTap: () => ref
                  .read(favoritesProvider.notifier)
                  .toggle(widget.view.id),
            ),
          ),
        ],
      );
    }

    final card = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: logoBox),
        const SizedBox(height: 8),
        Text(
          widget.view.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );

    return GestureDetector(
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      onTap: widget.onTap,
      child: AnimatedScale(
        scale: _pressed ? 0.94 : 1.0,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: widget.width.isFinite
            ? SizedBox(width: widget.width, child: card)
            : card,
      ),
    );
  }
}

class _HeartButton extends StatelessWidget {
  const _HeartButton({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.35),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 180),
            transitionBuilder: (child, anim) =>
                ScaleTransition(scale: anim, child: child),
            child: Icon(
              active ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              key: ValueKey(active),
              color: active ? AppColors.liveIndicator : Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoSquare extends StatelessWidget {
  const _LogoSquare({required this.url, required this.name});

  final String? url;
  final String name;

  @override
  Widget build(BuildContext context) {
    final fallback = LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest.shortestSide;
        return Container(
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: AppColors.border, width: 1),
          ),
          alignment: Alignment.center,
          child: Text(
            name.characters.first.toUpperCase(),
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w800,
              fontSize: size * 0.4,
            ),
          ),
        );
      },
    );

    Widget image;
    if (url == null || url!.isEmpty) {
      image = fallback;
    } else {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Container(
          color: AppColors.surface,
          padding: const EdgeInsets.all(10),
          child: CachedNetworkImage(
            imageUrl: url!,
            fit: BoxFit.contain,
            placeholder: (_, _) => const SizedBox.shrink(),
            errorWidget: (_, _, _) => fallback,
          ),
        ),
      );
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: image,
    );
  }
}
