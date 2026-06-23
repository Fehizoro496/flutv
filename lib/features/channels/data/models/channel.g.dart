// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Channel _$ChannelFromJson(Map<String, dynamic> json) => _Channel(
  id: json['id'] as String,
  name: json['name'] as String,
  altNames:
      (json['alt_names'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  network: json['network'] as String?,
  owners:
      (json['owners'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  country: json['country'] as String?,
  subdivision: json['subdivision'] as String?,
  city: json['city'] as String?,
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
  isNsfw: json['is_nsfw'] as bool? ?? false,
  launched: json['launched'] as String?,
  closed: json['closed'] as String?,
  replacedBy: json['replaced_by'] as String?,
  website: json['website'] as String?,
  logo: json['logo'] as String?,
);

Map<String, dynamic> _$ChannelToJson(_Channel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'alt_names': instance.altNames,
  'network': instance.network,
  'owners': instance.owners,
  'country': instance.country,
  'subdivision': instance.subdivision,
  'city': instance.city,
  'categories': instance.categories,
  'languages': instance.languages,
  'is_nsfw': instance.isNsfw,
  'launched': instance.launched,
  'closed': instance.closed,
  'replaced_by': instance.replacedBy,
  'website': instance.website,
  'logo': instance.logo,
};
