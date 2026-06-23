import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../constants/app_constants.dart';

class CacheStore {
  CacheStore(this._box, {Duration? ttl}) : _ttl = ttl ?? AppConstants.apiCacheDuration;

  final Box _box;
  final Duration _ttl;

  List<Map<String, dynamic>>? read(String key, {bool ignoreTtl = false}) {
    final entry = _box.get(key);
    if (entry is! Map) return null;
    final ts = entry['timestamp'];
    final data = entry['data'];
    if (ts is! int || data is! List) return null;
    if (!ignoreTtl) {
      final age = DateTime.now().millisecondsSinceEpoch - ts;
      if (age > _ttl.inMilliseconds) return null;
    }
    return data
        .whereType<Map>()
        .map((e) => e.cast<String, dynamic>())
        .toList(growable: false);
  }

  Future<void> write(String key, List<Map<String, dynamic>> data) async {
    await _box.put(key, {
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'data': data,
    });
  }

  Future<void> invalidate(String key) => _box.delete(key);
  Future<void> clear() => _box.clear();
}

final cacheStoreProvider = Provider<CacheStore>((ref) {
  final box = Hive.box<dynamic>(AppConstants.cacheBox);
  return CacheStore(box);
});
