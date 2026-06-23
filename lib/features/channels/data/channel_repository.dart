import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/cache_store.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/iptv_org_client.dart';
import 'models/category.dart';
import 'models/channel.dart';
import 'models/channel_view.dart';
import 'models/stream_link.dart';

class ChannelRepository {
  ChannelRepository(this._client, this._cache);

  final IptvOrgClient _client;
  final CacheStore _cache;

  static const _kChannels = 'channels';
  static const _kStreams = 'streams';
  static const _kCategories = 'categories';

  Future<List<ChannelView>> getChannels({bool refresh = false}) async {
    final channels = await _load(
      _kChannels,
      _client.fetchChannels,
      refresh: refresh,
    );
    final streams = await _load(
      _kStreams,
      _client.fetchStreams,
      refresh: refresh,
    );

    final byId = <String, StreamLink>{};
    for (final raw in streams) {
      try {
        final link = StreamLink.fromJson(raw);
        if (link.url.isEmpty) continue;
        final existing = byId[link.channel];
        if (existing == null || (existing.feed != null && link.feed == null)) {
          byId[link.channel] = link;
        }
      } catch (_) {
        // Skip malformed entries.
      }
    }

    final views = <ChannelView>[];
    for (final raw in channels) {
      try {
        final channel = Channel.fromJson(raw);
        if (!_isFrench(channel)) continue;
        final link = byId[channel.id];
        if (link == null) continue;
        views.add(ChannelView(channel: channel, stream: link));
      } catch (_) {
        // Skip malformed entries.
      }
    }

    views.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return views;
  }

  Future<List<Category>> getCategories({bool refresh = false}) async {
    final raw = await _load(
      _kCategories,
      _client.fetchCategories,
      refresh: refresh,
    );
    final list = <Category>[];
    for (final json in raw) {
      try {
        list.add(Category.fromJson(json));
      } catch (_) {
        // Skip malformed entries.
      }
    }
    list.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return list;
  }

  Future<List<Map<String, dynamic>>> _load(
    String key,
    Future<List<Map<String, dynamic>>> Function() fetch, {
    required bool refresh,
  }) async {
    if (!refresh) {
      final cached = _cache.read(key);
      if (cached != null) return cached;
    }
    final fresh = await fetch();
    await _cache.write(key, fresh);
    return fresh;
  }

  bool _isFrench(Channel channel) {
    if (channel.country?.toUpperCase() == AppConstants.targetCountryCode) {
      return true;
    }
    return channel.languages.contains(AppConstants.targetLanguageCode);
  }
}

final channelRepositoryProvider = Provider<ChannelRepository>((ref) {
  return ChannelRepository(
    ref.watch(iptvOrgClientProvider),
    ref.watch(cacheStoreProvider),
  );
});
