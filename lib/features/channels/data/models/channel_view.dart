import 'package:freezed_annotation/freezed_annotation.dart';

import 'channel.dart';
import 'stream_link.dart';

part 'channel_view.freezed.dart';

@freezed
abstract class ChannelView with _$ChannelView {
  const factory ChannelView({
    required Channel channel,
    required StreamLink stream,
  }) = _ChannelView;

  const ChannelView._();

  String get id => channel.id;
  String get name => channel.name;
  String? get logo => channel.logo;
  List<String> get categories => channel.categories;
  String get url => stream.url;
}
