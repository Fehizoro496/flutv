import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../core/theme/app_colors.dart';
import '../channels/data/models/channel_view.dart';
import '../channels/providers/channels_provider.dart';
import '../favorites/providers/favorites_provider.dart';
import 'widgets/player_controls.dart';

class PlayerScreen extends ConsumerStatefulWidget {
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
  ConsumerState<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends ConsumerState<PlayerScreen> {
  late final Player _player;
  late final VideoController _controller;
  final List<StreamSubscription<dynamic>> _subs = [];

  bool _playing = false;
  bool _buffering = true;
  bool _muted = false;
  double _volume = 100;
  bool _fullscreen = false;
  bool _showControls = true;
  bool _showVolumeOverlay = false;
  Timer? _hideControlsTimer;
  Timer? _hideVolumeTimer;
  String? _error;

  double? _dragStartVolume;
  Offset? _dragStartPosition;

  ChannelView? get _view =>
      widget.initial ?? ref.read(channelByIdProvider(widget.channelId));

  @override
  void initState() {
    super.initState();
    _player = Player();
    _controller = VideoController(_player);

    _subs.add(_player.stream.playing.listen((v) {
      if (mounted) {
        setState(() => _playing = v);
        _updateWakelock();
      }
    }));
    _subs.add(_player.stream.buffering.listen((v) {
      if (mounted) setState(() => _buffering = v);
    }));
    _subs.add(_player.stream.volume.listen((v) {
      if (mounted) setState(() => _volume = v);
    }));
    _subs.add(_player.stream.error.listen((e) {
      if (!mounted) return;
      if (_isFatalError(e)) {
        setState(() => _error = e);
      } else {
        debugPrint('PlayerScreen ignored non-fatal mpv message: $e');
      }
    }));

    _scheduleHideControls();
    _openStream();
  }

  Future<void> _openStream() async {
    final view = _view;
    if (view == null) {
      setState(() => _error = 'Chaîne introuvable.');
      return;
    }
    setState(() => _error = null);
    final headers = <String, String>{};
    if (view.stream.referrer != null && view.stream.referrer!.isNotEmpty) {
      headers['Referer'] = view.stream.referrer!;
    }
    if (view.stream.userAgent != null && view.stream.userAgent!.isNotEmpty) {
      headers['User-Agent'] = view.stream.userAgent!;
    }
    await _player.open(
      Media(view.stream.url, httpHeaders: headers.isEmpty ? null : headers),
    );
  }

  static const _ignoredErrorPatterns = <String>[
    'force-seekable',
    'seekable',
    'cache',
    'demuxer-readahead',
  ];

  bool _isFatalError(String message) {
    final lower = message.toLowerCase();
    return !_ignoredErrorPatterns.any(lower.contains);
  }

  Future<void> _updateWakelock() async {
    if (_playing) {
      await WakelockPlus.enable();
    } else {
      await WakelockPlus.disable();
    }
  }

  void _scheduleHideControls() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  void _toggleControls() {
    setState(() => _showControls = !_showControls);
    if (_showControls) _scheduleHideControls();
  }

  Future<void> _togglePlayPause() async {
    await _player.playOrPause();
    _scheduleHideControls();
  }

  Future<void> _toggleMute() async {
    _muted = !_muted;
    await _player.setVolume(_muted ? 0 : 100);
    _scheduleHideControls();
  }

  Future<void> _toggleFullscreen() async {
    _fullscreen = !_fullscreen;
    if (_fullscreen) {
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    } else {
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    if (mounted) setState(() {});
    _scheduleHideControls();
  }

  void _onVerticalDragStart(DragStartDetails details) {
    _dragStartVolume = _volume;
    _dragStartPosition = details.localPosition;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_dragStartVolume == null || _dragStartPosition == null) return;
    final box = context.findRenderObject() as RenderBox?;
    if (box == null) return;
    final dy = details.localPosition.dy - _dragStartPosition!.dy;
    final delta = (-dy / box.size.height) * 150;
    final newVolume = (_dragStartVolume! + delta).clamp(0.0, 100.0);
    _player.setVolume(newVolume);
    _muted = newVolume == 0;
    setState(() {
      _showVolumeOverlay = true;
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    _dragStartVolume = null;
    _dragStartPosition = null;
    _hideVolumeTimer?.cancel();
    _hideVolumeTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) setState(() => _showVolumeOverlay = false);
    });
  }

  Future<void> _exitFullscreenIfNeeded() async {
    if (_fullscreen) {
      _fullscreen = false;
      await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    _hideVolumeTimer?.cancel();
    for (final s in _subs) {
      s.cancel();
    }
    _player.dispose();
    WakelockPlus.disable();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final view = _view;
    final title = view?.name ?? 'Chaîne';

    Widget video = Container(
      color: Colors.black,
      child: Video(
        controller: _controller,
        controls: NoVideoControls,
        fill: Colors.black,
      ),
    );
    if (widget.heroTag != null) {
      video = Hero(tag: widget.heroTag!, child: video);
    }

    final body = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleControls,
      onDoubleTap: _toggleFullscreen,
      onVerticalDragStart: _onVerticalDragStart,
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: Stack(
        fit: StackFit.expand,
        children: [
          video,
          if (_buffering && _error == null)
            const Center(
              child: SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              ),
            ),
          if (_error != null)
            _ErrorOverlay(
              message: _error!,
              onRetry: _openStream,
              onBack: () async {
                await _exitFullscreenIfNeeded();
                if (context.mounted) context.pop();
              },
            ),
          AnimatedOpacity(
            opacity: _showControls && _error == null ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: IgnorePointer(
              ignoring: !_showControls || _error != null,
              child: PlayerControls(
                title: title,
                playing: _playing,
                buffering: _buffering,
                muted: _muted,
                fullscreen: _fullscreen,
                favorite: ref.watch(isFavoriteProvider(widget.channelId)),
                onPlayPause: _togglePlayPause,
                onMute: _toggleMute,
                onFullscreen: _toggleFullscreen,
                onFavorite: () {
                  ref
                      .read(favoritesProvider.notifier)
                      .toggle(widget.channelId);
                  _scheduleHideControls();
                },
                onBack: () async {
                  await _exitFullscreenIfNeeded();
                  if (context.mounted) context.pop();
                },
              ),
            ),
          ),
          if (_showVolumeOverlay)
            Align(
              alignment: Alignment.center,
              child: PlayerVolumeIndicator(volume: _volume),
            ),
        ],
      ),
    );

    return PopScope(
      canPop: !_fullscreen,
      onPopInvokedWithResult: (didPop, _) async {
        if (!didPop && _fullscreen) {
          await _toggleFullscreen();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: body,
      ),
    );
  }
}

class _ErrorOverlay extends StatelessWidget {
  const _ErrorOverlay({
    required this.message,
    required this.onRetry,
    required this.onBack,
  });

  final String message;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withValues(alpha: 0.85),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline_rounded,
                  color: AppColors.error, size: 48),
              const SizedBox(height: 16),
              const Text(
                'Flux indisponible',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back_rounded),
                    label: const Text('Retour'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white54),
                    ),
                  ),
                  const SizedBox(width: 12),
                  FilledButton.icon(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Réessayer'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
