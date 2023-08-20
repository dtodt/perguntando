import 'package:perguntando/src/features/conferences/interactor/entities/question_entity.dart';

import '../models/question_model.dart';

class QuestionAdapter {
  static QuestionModel fromJson(dynamic json) => QuestionModel(
        id: json['id'],
        userId: json['userId'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        text: json['text'],
        talkId: json['talkId'],
        likes: LikeAdapter.fromList(json['likes']),
      );

  static List<QuestionModel> fromJsonList(List list) =>
      list.map(fromJson).toList();

  static QuestionEntity fromModel(String userId, QuestionModel model) {
    final isLikedForMe = model.likes.any((like) => like.userId == userId);

    return QuestionEntryEntity(
      id: model.id,
      profileImage: model.imageUrl,
      profileName: model.name,
      text: model.text,
      likes: model.likes.length,
      isLikedForMe: isLikedForMe,
      isMine: model.userId == userId,
    );
  }

  static List<QuestionEntity> fromList(String userId, List list) =>
      fromJsonList(list).map((model) => fromModel(userId, model)).toList();
}

class LikeAdapter {
  static LikeModel fromJson(dynamic data) => LikeModel(
        id: data['id'],
        questionId: data['questionId'],
        userId: data['userId'],
      );

  static List<LikeModel> fromList(List data) => data.map(fromJson).toList();
}
