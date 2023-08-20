import '../entities/question_entity.dart';

sealed class QuestionsState {}

class QuestionsInitial extends QuestionsState {}

class QuestionsLoading extends QuestionsState {}

class QuestionsFailure extends QuestionsState {
  final String message;
  QuestionsFailure(this.message);
}

class QuestionsSuccess extends QuestionsState {
  final List<QuestionEntity> questions;
  QuestionsSuccess(this.questions);
}
