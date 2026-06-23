import '../channels/data/models/channel_view.dart';

class PlayerArgs {
  const PlayerArgs({required this.view, this.heroTag});

  final ChannelView view;
  final String? heroTag;
}
