import 'package:perguntando/src/features/conferences/interactor/entities/conference_entity.dart';

class ConferenceAdapter {
  static ConferenceEntity fromJson(dynamic data) => ConferenceEntryEntity(
        id: data['id'],
        title: data['title'],
        imageUrl: data['imageUrl'],
      );

  static List<ConferenceEntity> fromList(List data) =>
      data.map(fromJson).toList();
}
