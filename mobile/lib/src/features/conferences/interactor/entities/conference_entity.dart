sealed class ConferenceEntity {}

class ConferenceTitleEntity extends ConferenceEntity {
  final String title;

  ConferenceTitleEntity({
    required this.title,
  });
}

class ConferenceEntryEntity extends ConferenceEntity {
  final int id;
  final String title;
  final String imageUrl;

  ConferenceEntryEntity({
    required this.id,
    required this.title,
    required this.imageUrl,
  });
}
