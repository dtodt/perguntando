import '../states/conferences_state.dart';
import '../states/questions_state.dart';
import '../states/talks_state.dart';

abstract class ConferencesService {
  Future<ConferencesState> fetchAllConferences();
  Future<TalksState> fetchTalksByConferenceId(int id);
  Future<QuestionsState> fetchQuestionsByTalkId(int id);
  Future<QuestionsState> createQuestion(String text, int talkId);
  Future<QuestionsState> likeQuestion(int id, int talkId);
  Future<QuestionsState> deleteQuestion(int id, int talkId);
  Future<QuestionsState> unlikeQuestion(int id, int talkId);
}
