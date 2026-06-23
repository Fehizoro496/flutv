/// Manually-configured XMLTV sources.
///
/// iptv-org/api `guides.json` rarely contains usable URLs (only ~2 of 167k
/// entries have a hosted source). To get real EPG data you need to add
/// community-hosted XMLTV URLs here. Each URL is fetched once, parsed, and
/// programmes are indexed per channel-id matching `Channel.id` from
/// iptv-org/api (e.g. `TF1.fr`).
///
/// Example:
/// ```dart
/// const epgManualXmltvUrls = <String>[
///   'https://example.com/fr.xml',
/// ];
/// ```
const epgManualXmltvUrls = <String>[];
