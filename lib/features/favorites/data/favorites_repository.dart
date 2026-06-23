import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../core/constants/app_constants.dart';

class FavoritesRepository {
  FavoritesRepository(this._box);

  static const _key = 'ids';

  final Box _box;

  Set<String> readIds() {
    final raw = _box.get(_key);
    if (raw is List) return raw.whereType<String>().toSet();
    return <String>{};
  }

  Future<void> writeIds(Set<String> ids) =>
      _box.put(_key, ids.toList(growable: false));
}

final favoritesRepositoryProvider = Provider<FavoritesRepository>((ref) {
  final box = Hive.box<dynamic>(AppConstants.favoritesBox);
  return FavoritesRepository(box);
});
