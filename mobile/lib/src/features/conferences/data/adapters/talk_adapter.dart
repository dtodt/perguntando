import 'package:perguntando/src/features/conferences/interactor/entities/talk_entity.dart';

class TalkAdapter {
  static TalkEntity fromJson(dynamic data) => TalkEntryEntity(
        id: data['id'],
        speaker: data['speaker'],
        description: data['description'],
        imageUrl: data['speakerImage'],
      );

  static List<TalkEntity> fromList(List data) => data.map(fromJson).toList();
}
