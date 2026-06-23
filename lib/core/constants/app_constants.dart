class AppConstants {
  AppConstants._();

  static const String appName = 'Flutv';

  static const String iptvApiBase = 'https://iptv-org.github.io/api';
  static const String channelsEndpoint = '$iptvApiBase/channels.json';
  static const String streamsEndpoint = '$iptvApiBase/streams.json';
  static const String categoriesEndpoint = '$iptvApiBase/categories.json';
  static const String countriesEndpoint = '$iptvApiBase/countries.json';

  static const String targetCountryCode = 'FR';
  static const String targetLanguageCode = 'fra';

  static const Duration apiCacheDuration = Duration(hours: 24);
  static const Duration apiTimeout = Duration(seconds: 15);

  static const String favoritesBox = 'favorites';
  static const String cacheBox = 'cache';

  static const String epgGuidesEndpoint = '$iptvApiBase/guides.json';
  static const Duration epgCacheDuration = Duration(hours: 6);
}
