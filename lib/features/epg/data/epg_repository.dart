import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/cache_store.dart';
import '../../../core/network/dio_provider.dart';
import 'epg_client.dart';
import 'epg_overrides.dart';
import 'models/epg_programme.dart';

class EpgRepository {
  EpgRepository(this._client, this._cache);

  final EpgClient _client;
  final CacheStore _cache;

  static const _kSources = 'epg_sources';
  static const _kManualLoaded = 'epg_manual_loaded';
  static const _frenchLangs = {'fr', 'fra', 'fr-fr', 'fr_fr'};

  Map<String, EpgSource>? _sourceByChannel;
  bool _manualPreloadStarted = false;

  String _programmesKey(String channelId) => 'epg_prog_$channelId';

  Future<List<EpgProgramme>> getProgrammes(
    String channelId, {
    bool refresh = false,
  }) async {
    final cacheKey = _programmesKey(channelId);
    if (!refresh) {
      final cached = _cache.read(cacheKey);
      if (cached != null) {
        return cached.map(EpgProgramme.fromJson).toList(growable: false);
      }
    }

    await _preloadManualSourcesIfNeeded(refresh: refresh);

    final cachedAfterManual = _cache.read(cacheKey);
    if (cachedAfterManual != null) {
      return cachedAfterManual
          .map(EpgProgramme.fromJson)
          .toList(growable: false);
    }

    final source = await _resolveSource(channelId);
    if (source == null) return const [];
    final fresh = await _client.fetchProgrammes(source.url);
    return _storeAndReturnForChannel(fresh, channelId);
  }

  List<EpgProgramme>? getProgrammesFromCache(String channelId) {
    final cached = _cache.read(_programmesKey(channelId));
    if (cached == null) return null;
    return cached.map(EpgProgramme.fromJson).toList(growable: false);
  }

  Future<void> _preloadManualSourcesIfNeeded({required bool refresh}) async {
    if (_manualPreloadStarted && !refresh) return;
    _manualPreloadStarted = true;
    if (epgManualXmltvUrls.isEmpty) return;
    if (!refresh && _cache.read(_kManualLoaded) != null) return;
    for (final url in epgManualXmltvUrls) {
      try {
        final programmes = await _client.fetchProgrammes(url);
        _indexAndCache(programmes);
      } catch (_) {
        // Skip unreachable sources; partial preload is still useful.
      }
    }
    await _cache.write(_kManualLoaded, const []);
  }

  void _indexAndCache(List<EpgProgramme> programmes) {
    final byChannel = <String, List<EpgProgramme>>{};
    for (final p in programmes) {
      byChannel.putIfAbsent(p.channelId, () => []).add(p);
    }
    for (final entry in byChannel.entries) {
      entry.value.sort((a, b) => a.start.compareTo(b.start));
      _cache.write(
        _programmesKey(entry.key),
        entry.value.map((p) => p.toJson()).toList(growable: false),
      );
    }
  }

  List<EpgProgramme> _storeAndReturnForChannel(
    List<EpgProgramme> all,
    String channelId,
  ) {
    _indexAndCache(all);
    return all
        .where((p) => p.channelId == channelId)
        .toList(growable: false)
      ..sort((a, b) => a.start.compareTo(b.start));
  }

  Future<EpgSource?> _resolveSource(String channelId) async {
    final map = await _ensureSources();
    return map[channelId];
  }

  Future<Map<String, EpgSource>> _ensureSources() async {
    if (_sourceByChannel != null) return _sourceByChannel!;
    final List<EpgSource> sources;
    final cached = _cache.read(_kSources);
    if (cached != null) {
      sources = cached
          .map((m) => EpgSource(
                channelId: m['channelId'] as String,
                url: m['url'] as String,
                lang: m['lang'] as String?,
              ))
          .toList(growable: false);
    } else {
      sources = await _client.fetchSources();
      await _cache.write(
        _kSources,
        sources
            .map((s) => {
                  'channelId': s.channelId,
                  'url': s.url,
                  if (s.lang != null) 'lang': s.lang,
                })
            .toList(),
      );
    }
    final byChannel = <String, EpgSource>{};
    for (final source in sources) {
      final lang = source.lang?.toLowerCase();
      final isFrench = lang == null || _frenchLangs.contains(lang);
      final existing = byChannel[source.channelId];
      if (existing == null || (existing.lang == null && isFrench)) {
        byChannel[source.channelId] = source;
      }
    }
    _sourceByChannel = byChannel;
    return byChannel;
  }
}

final epgClientProvider = Provider<EpgClient>(
  (ref) => EpgClient(ref.watch(dioProvider)),
);

final epgRepositoryProvider = Provider<EpgRepository>((ref) {
  final box = Hive.box<dynamic>(AppConstants.cacheBox);
  return EpgRepository(
    ref.watch(epgClientProvider),
    CacheStore(box, ttl: AppConstants.epgCacheDuration),
  );
});
