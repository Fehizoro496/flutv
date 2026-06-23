import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/epg_repository.dart';
import '../data/models/epg_programme.dart';

final programmesProvider =
    FutureProvider.autoDispose.family<List<EpgProgramme>, String>((ref, channelId) {
  return ref.watch(epgRepositoryProvider).getProgrammes(channelId);
});

/// Cached-only lookup — never triggers a network fetch.
final cachedProgrammesProvider =
    Provider.family<List<EpgProgramme>, String>((ref, channelId) {
  return ref.watch(epgRepositoryProvider).getProgrammesFromCache(channelId) ??
      const [];
});

EpgProgramme? _currentIn(List<EpgProgramme> list) {
  final now = DateTime.now();
  for (final p in list) {
    if (p.isLiveAt(now)) return p;
  }
  return null;
}

EpgProgramme? _nextAfter(List<EpgProgramme> list) {
  final now = DateTime.now();
  for (final p in list) {
    if (p.start.isAfter(now)) return p;
  }
  return null;
}

final currentProgrammeProvider =
    Provider.family<EpgProgramme?, String>((ref, channelId) {
  return _currentIn(ref.watch(cachedProgrammesProvider(channelId)));
});

final nextProgrammeProvider =
    Provider.family<EpgProgramme?, String>((ref, channelId) {
  return _nextAfter(ref.watch(cachedProgrammesProvider(channelId)));
});
