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

final featuredChannelsProvider = Provider<List<ChannelView>>((ref) {
  final channels = ref.watch(channelsProvider).asData?.value ?? const [];
  return channels.where((c) => c.logo != null && c.logo!.isNotEmpty).take(6).toList();
});

class HomeRail {
  const HomeRail({required this.label, required this.categoryIds});
  final String label;
  final List<String> categoryIds;
}

const homeRailPresets = <HomeRail>[
  HomeRail(label: 'Info', categoryIds: ['news']),
  HomeRail(label: 'Sport', categoryIds: ['sports']),
  HomeRail(label: 'Cinéma', categoryIds: ['movies']),
  HomeRail(label: 'Jeunesse', categoryIds: ['kids']),
  HomeRail(label: 'Divertissement', categoryIds: ['entertainment', 'general']),
];

class HomeRailData {
  const HomeRailData({required this.label, required this.categoryId, required this.channels});
  final String label;
  final String categoryId;
  final List<ChannelView> channels;
}

final homeRailsProvider = Provider<List<HomeRailData>>((ref) {
  final grouped = ref.watch(channelsByCategoryProvider);
  final rails = <HomeRailData>[];
  for (final preset in homeRailPresets) {
    for (final id in preset.categoryIds) {
      final list = grouped[id];
      if (list != null && list.isNotEmpty) {
        rails.add(HomeRailData(label: preset.label, categoryId: id, channels: list));
        break;
      }
    }
  }
  return rails;
});

final categoryChannelsProvider = Provider.family<List<ChannelView>, String>((ref, id) {
  final grouped = ref.watch(channelsByCategoryProvider);
  return grouped[id] ?? const [];
});

final channelByIdProvider = Provider.family<ChannelView?, String>((ref, id) {
  final channels = ref.watch(channelsProvider).asData?.value ?? const [];
  for (final c in channels) {
    if (c.id == id) return c;
  }
  return null;
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = Provider<List<ChannelView>>((ref) {
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final channels = ref.watch(channelsProvider).asData?.value ?? const [];
  if (query.isEmpty) return channels;
  return channels.where((c) => c.name.toLowerCase().contains(query)).toList();
});

Future<void> refreshChannels(WidgetRef ref) async {
  ref.invalidate(channelsProvider);
  ref.invalidate(categoriesProvider);
  await ref.read(channelsProvider.future);
}
