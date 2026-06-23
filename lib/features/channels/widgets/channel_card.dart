import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../data/models/channel_view.dart';

class ChannelCard extends StatefulWidget {
  const ChannelCard({
    super.key,
    required this.view,
    required this.onTap,
    this.width = 112,
    this.heroTag,
  });

  final ChannelView view;
  final VoidCallback onTap;
  final double width;
  final String? heroTag;

  @override
  State<ChannelCard> createState() => _ChannelCardState();
}

class _ChannelCardState extends State<ChannelCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget logo = AspectRatio(
      aspectRatio: 1,
      child: _LogoSquare(url: widget.view.logo, name: widget.view.name),
    );
    if (widget.heroTag != null) {
      logo = Hero(tag: widget.heroTag!, child: logo);
    }

    final card = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        logo,
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
