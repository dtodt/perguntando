sealed class QuestionEntity {}

class QuestionTitleEntity extends QuestionEntity {
  final String title;
  final String subtitle;

  QuestionTitleEntity({
    required this.title,
    required this.subtitle,
  });
}

class QuestionCreateEntity extends QuestionEntity {}

class QuestionEntryEntity extends QuestionEntity {
  final int id;
  final String profileImage;
  final String profileName;
  final String text;
  final int likes;
  final bool isLikedForMe;
  final bool isMine;

  QuestionEntryEntity({
    required this.id,
    required this.profileImage,
    required this.profileName,
    required this.text,
    required this.likes,
    required this.isLikedForMe,
    required this.isMine,
  });

  QuestionEntryEntity copyWith({bool? isLikedForMe}) => QuestionEntryEntity(
        id: id,
        profileImage: profileImage,
        profileName: profileName,
        text: text,
        likes: likes,
        isLikedForMe: isLikedForMe ?? this.isLikedForMe,
        isMine: isMine,
      );
}
