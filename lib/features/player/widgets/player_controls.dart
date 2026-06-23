import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls({
    super.key,
    required this.title,
    required this.playing,
    required this.buffering,
    required this.muted,
    required this.fullscreen,
    required this.favorite,
    required this.onPlayPause,
    required this.onMute,
    required this.onFullscreen,
    required this.onFavorite,
    required this.onBack,
  });

  final String title;
  final bool playing;
  final bool buffering;
  final bool muted;
  final bool fullscreen;
  final bool favorite;
  final VoidCallback onPlayPause;
  final VoidCallback onMute;
  final VoidCallback onFullscreen;
  final VoidCallback onFavorite;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: false,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.55),
              Colors.transparent,
              Colors.transparent,
              Colors.black.withValues(alpha: 0.65),
            ],
            stops: const [0.0, 0.25, 0.65, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _TopBar(
                title: title,
                favorite: favorite,
                onBack: onBack,
                onFavorite: onFavorite,
              ),
              Expanded(
                child: Center(
                  child: buffering
                      ? const SizedBox.shrink()
                      : _PlayPauseButton(playing: playing, onTap: onPlayPause),
                ),
              ),
              _BottomBar(
                muted: muted,
                fullscreen: fullscreen,
                onMute: onMute,
                onFullscreen: onFullscreen,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({
    required this.title,
    required this.favorite,
    required this.onBack,
    required this.onFavorite,
  });

  final String title;
  final bool favorite;
  final VoidCallback onBack;
  final VoidCallback onFavorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
            onPressed: onBack,
          ),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              favorite
                  ? Icons.favorite_rounded
                  : Icons.favorite_border_rounded,
              color: favorite ? AppColors.liveIndicator : Colors.white,
            ),
            onPressed: onFavorite,
          ),
          const SizedBox(width: 4),
          const _LiveBadge(),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.muted,
    required this.fullscreen,
    required this.onMute,
    required this.onFullscreen,
  });

  final bool muted;
  final bool fullscreen;
  final VoidCallback onMute;
  final VoidCallback onFullscreen;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
              color: Colors.white,
            ),
            onPressed: onMute,
          ),
          const Spacer(),
          IconButton(
            icon: Icon(
              fullscreen ? Icons.fullscreen_exit_rounded : Icons.fullscreen_rounded,
              color: Colors.white,
            ),
            onPressed: onFullscreen,
          ),
        ],
      ),
    );
  }
}

class _PlayPauseButton extends StatelessWidget {
  const _PlayPauseButton({required this.playing, required this.onTap});

  final bool playing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withValues(alpha: 0.4),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(
            playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
            size: 56,
            color: Colors.white,
          ),
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
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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

class PlayerVolumeIndicator extends StatelessWidget {
  const PlayerVolumeIndicator({super.key, required this.volume});

  final double volume;

  @override
  Widget build(BuildContext context) {
    final pct = volume.clamp(0.0, 100.0);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            pct == 0
                ? Icons.volume_off_rounded
                : pct < 50
                    ? Icons.volume_down_rounded
                    : Icons.volume_up_rounded,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 120,
            child: LinearProgressIndicator(
              value: pct / 100,
              color: Colors.white,
              backgroundColor: Colors.white.withValues(alpha: 0.25),
              minHeight: 4,
            ),
          ),
        ],
      ),
    );
  }
}
