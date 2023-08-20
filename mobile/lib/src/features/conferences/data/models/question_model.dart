class QuestionModel {
  final int id;
  final String userId;
  final String name;
  final String imageUrl;
  final String text;
  final int talkId;
  final List<LikeModel> likes;

  const QuestionModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.text,
    required this.talkId,
    required this.likes,
  });
}

class LikeModel {
  final int id;
  final int questionId;
  final String userId;

  const LikeModel({
    required this.id,
    required this.questionId,
    required this.userId,
  });
}
