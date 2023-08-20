import 'package:asp/asp.dart';

import '../atoms/atoms.dart';
import '../entities/question_entity.dart';
import '../services/conferences_service.dart';
import '../states/conferences_state.dart';
import '../states/questions_state.dart';
import '../states/talks_state.dart';

class ConferencesReducer extends Reducer {
  final ConferencesService service;

  ConferencesReducer(this.service) {
    on(() => [fetchAllConferencesAction], _fetchAllConferences);
    on(() => [fetchTalksByConferenceAction], _fetchTalksByConferenceId);
    on(() => [fetchQuestionsByTalkAction], _fetchQuestionsByTalkId);
    on(() => [addQuestionAction], _addQuestionAction);
    on(() => [removeQuestionAction], _removeQuestionAction);
    on(() => [likeQuestionAction], _likeQuestionAction);
    on(() => [executeLikeQuestionAction], _executeLikeQuestionAction);
  }

  void _fetchAllConferences() {
    conferencesState.value = ConferencesLoading();

    service.fetchAllConferences().then(conferencesState.setValue);
  }

  void _fetchTalksByConferenceId() {
    talksState.value = TalksLoading();

    final id = fetchTalksByConferenceAction.value!.id;
    service.fetchTalksByConferenceId(id).then(talksState.setValue);
  }

  void _fetchQuestionsByTalkId() {
    questionsState.value = QuestionsLoading();

    final id = fetchQuestionsByTalkAction.value!.id;
    service.fetchQuestionsByTalkId(id).then(questionsState.setValue);
  }

  void _addQuestionAction() {
    final dto = addQuestionAction.value!;
    service.createQuestion(dto.text, dto.talkId).then(questionsState.setValue);
  }

  void _removeQuestionAction() {
    final dto = removeQuestionAction.value!;
    service
        .deleteQuestion(dto.questionId, dto.talkId)
        .then(questionsState.setValue);
  }

  void _likeQuestionAction() {
    final dto = likeQuestionAction.value!;
    final state = questionsState.value as QuestionsSuccess;
    final questions = state.questions.toList();

    final questionIndex = questions.indexWhere(
        (item) => item is QuestionEntryEntity && item.id == dto.questionId);
    final question = questions[questionIndex];
    if (question is QuestionEntryEntity) {
      questions[questionIndex] = question.copyWith(
        isLikedForMe: dto.isLiked,
      );
      questionsState.value = QuestionsSuccess(questions);
    }
    executeLikeQuestionAction();
  }

  void _executeLikeQuestionAction() {
    final dto = likeQuestionAction.value!;
    Future<QuestionsState> state;
    if (dto.isLiked) {
      state = service.likeQuestion(dto.questionId, dto.talkId);
    } else {
      state = service.unlikeQuestion(dto.questionId, dto.talkId);
    }
    state.then(questionsState.setValue);
  }
}
