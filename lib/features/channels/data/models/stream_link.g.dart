// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stream_link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StreamLink _$StreamLinkFromJson(Map<String, dynamic> json) => _StreamLink(
  channel: json['channel'] as String,
  feed: json['feed'] as String?,
  title: json['title'] as String?,
  url: json['url'] as String,
  referrer: json['referrer'] as String?,
  userAgent: json['user_agent'] as String?,
  quality: json['quality'] as String?,
);

Map<String, dynamic> _$StreamLinkToJson(_StreamLink instance) =>
    <String, dynamic>{
      'channel': instance.channel,
      'feed': instance.feed,
      'title': instance.title,
      'url': instance.url,
      'referrer': instance.referrer,
      'user_agent': instance.userAgent,
      'quality': instance.quality,
    };
