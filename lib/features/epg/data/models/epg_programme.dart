class EpgProgramme {
  const EpgProgramme({
    required this.channelId,
    required this.start,
    required this.stop,
    required this.title,
    this.description,
    this.category,
  });

  final String channelId;
  final DateTime start;
  final DateTime stop;
  final String title;
  final String? description;
  final String? category;

  Duration get duration => stop.difference(start);

  bool isLiveAt(DateTime when) =>
      !when.isBefore(start) && when.isBefore(stop);

  Map<String, dynamic> toJson() => {
        'channelId': channelId,
        'start': start.toIso8601String(),
        'stop': stop.toIso8601String(),
        'title': title,
        if (description != null) 'description': description,
        if (category != null) 'category': category,
      };

  factory EpgProgramme.fromJson(Map<String, dynamic> json) => EpgProgramme(
        channelId: json['channelId'] as String,
        start: DateTime.parse(json['start'] as String),
        stop: DateTime.parse(json['stop'] as String),
        title: json['title'] as String,
        description: json['description'] as String?,
        category: json['category'] as String?,
      );
}

class EpgSource {
  const EpgSource({required this.channelId, required this.url, this.lang});

  final String channelId;
  final String url;
  final String? lang;
}
