sealed class TalkEntity {}

class TalkTitleEntity extends TalkEntity {
  final String title;
  final String subtitle;

  TalkTitleEntity({
    required this.title,
    required this.subtitle,
  });
}

class TalkEntryEntity extends TalkEntity {
  final int id;
  final String speaker;
  final String description;
  final String imageUrl;

  TalkEntryEntity({
    required this.id,
    required this.speaker,
    required this.description,
    required this.imageUrl,
  });
}
