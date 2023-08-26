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
    on(() => [addQuestionAction], _addQuestion);
    on(() => [removeQuestionAction], _removeQuestion);
    on(() => [likeQuestionAction], _likeQuestion,
        filter: () => questionsState.value is QuestionsSuccess);
    on(() => [executeLikeQuestionAction], _executeLikeQuestion);
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

  void _addQuestion() {
    final (:talkId, :text) = addQuestionAction.value!;
    service.createQuestion(text, talkId).then(questionsState.setValue);
  }

  void _removeQuestion() {
    final (:talkId, :questionId) = removeQuestionAction.value!;
    service.deleteQuestion(questionId, talkId).then(questionsState.setValue);
  }

  void _likeQuestion() {
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

  void _executeLikeQuestion() {
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
