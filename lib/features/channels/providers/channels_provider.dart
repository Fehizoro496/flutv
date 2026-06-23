import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/channel_repository.dart';
import '../data/models/category.dart';
import '../data/models/channel_view.dart';

final channelsProvider = FutureProvider<List<ChannelView>>((ref) async {
  final repo = ref.watch(channelRepositoryProvider);
  return repo.getChannels();
});

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  final repo = ref.watch(channelRepositoryProvider);
  return repo.getCategories();
});

final channelsByCategoryProvider = Provider<Map<String, List<ChannelView>>>((ref) {
  final channels = ref.watch(channelsProvider).asData?.value ?? const [];
  final grouped = <String, List<ChannelView>>{};
  for (final view in channels) {
    if (view.categories.isEmpty) {
      grouped.putIfAbsent('', () => []).add(view);
      continue;
    }
    for (final cat in view.categories) {
      grouped.putIfAbsent(cat, () => []).add(view);
    }
  }
  return grouped;
});

Future<void> refreshChannels(WidgetRef ref) async {
  ref.invalidate(channelsProvider);
  ref.invalidate(categoriesProvider);
  await ref.read(channelsProvider.future);
}
