import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel.freezed.dart';
part 'channel.g.dart';

@freezed
abstract class Channel with _$Channel {
  const factory Channel({
    required String id,
    required String name,
    @Default(<String>[]) List<String> altNames,
    String? network,
    @Default(<String>[]) List<String> owners,
    String? country,
    String? subdivision,
    String? city,
    @Default(<String>[]) List<String> categories,
    @Default(<String>[]) List<String> languages,
    @Default(false) bool isNsfw,
    String? launched,
    String? closed,
    String? replacedBy,
    String? website,
    String? logo,
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) => _$ChannelFromJson(json);
}
