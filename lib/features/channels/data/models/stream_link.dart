import 'package:freezed_annotation/freezed_annotation.dart';

part 'stream_link.freezed.dart';
part 'stream_link.g.dart';

@freezed
abstract class StreamLink with _$StreamLink {
  const factory StreamLink({
    required String channel,
    String? feed,
    String? title,
    required String url,
    String? referrer,
    String? userAgent,
    String? quality,
  }) = _StreamLink;

  factory StreamLink.fromJson(Map<String, dynamic> json) =>
      _$StreamLinkFromJson(json);
}
