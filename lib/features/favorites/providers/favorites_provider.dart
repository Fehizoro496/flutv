import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../channels/data/models/channel_view.dart';
import '../../channels/providers/channels_provider.dart';
import '../data/favorites_repository.dart';

class FavoritesNotifier extends StateNotifier<Set<String>> {
  FavoritesNotifier(this._repo) : super(_repo.readIds());

  final FavoritesRepository _repo;

  bool contains(String id) => state.contains(id);

  Future<void> toggle(String id) async {
    final next = {...state};
    if (!next.add(id)) next.remove(id);
    state = next;
    await _repo.writeIds(next);
  }

  Future<void> remove(String id) async {
    if (!state.contains(id)) return;
    final next = {...state}..remove(id);
    state = next;
    await _repo.writeIds(next);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, Set<String>>((ref) {
  return FavoritesNotifier(ref.watch(favoritesRepositoryProvider));
});

final isFavoriteProvider = Provider.family<bool, String>((ref, id) {
  return ref.watch(favoritesProvider).contains(id);
});

final favoriteChannelsProvider = Provider<List<ChannelView>>((ref) {
  final ids = ref.watch(favoritesProvider);
  if (ids.isEmpty) return const [];
  final channels = ref.watch(channelsProvider).asData?.value ?? const [];
  final byId = {for (final c in channels) c.id: c};
  return ids
      .map((id) => byId[id])
      .whereType<ChannelView>()
      .toList(growable: false);
});
