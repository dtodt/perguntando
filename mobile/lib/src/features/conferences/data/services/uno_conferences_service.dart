import 'package:firebase_auth/firebase_auth.dart';
import 'package:perguntando/src/features/conferences/interactor/services/conferences_service.dart';
import 'package:perguntando/src/features/conferences/interactor/states/conferences_state.dart';
import 'package:perguntando/src/features/conferences/interactor/states/questions_state.dart';
import 'package:perguntando/src/features/conferences/interactor/states/talks_state.dart';
import 'package:uno/uno.dart';

import '../adapters/conference_adapter.dart';
import '../adapters/question_adapter.dart';
import '../adapters/talk_adapter.dart';

class UnoConferencesService extends ConferencesService {
  final Uno uno;
  final FirebaseAuth auth;

  UnoConferencesService(this.uno, this.auth);

  @override
  Future<ConferencesState> fetchAllConferences() async {
    try {
      final response = await uno.get('/conferences');
      final conferences = ConferenceAdapter.fromList(response.data);
      return ConferencesSuccess(conferences);
    } on UnoError {
      return ConferencesFailure('Conferences fetch error');
    }
  }

  @override
  Future<TalksState> fetchTalksByConferenceId(int id) async {
    try {
      final response = await uno.get('/talks/$id');
      final talks = TalkAdapter.fromList(response.data);
      return TalksSuccess(talks);
    } on UnoError {
      return TalksFailure('Talks fetch error');
    }
  }

  @override
  Future<QuestionsState> fetchQuestionsByTalkId(int id) async {
    try {
      final userId = auth.currentUser!.uid;
      final response = await uno.get('/questions/$id');
      final questions = QuestionAdapter.fromList(userId, response.data);
      return QuestionsSuccess(questions);
    } on UnoError {
      return QuestionsFailure('Questions fetch error');
    }
  }

  @override
  Future<QuestionsState> createQuestion(String text, int talkId) async {
    try {
      final user = auth.currentUser!;
      await uno.post('/questions', data: {
        "userId": user.uid,
        "name": user.displayName ?? 'Anonymous',
        "imageUrl": user.photoURL ?? 'http://www.gravatar.com/avatar/?d=mp',
        "text": text,
        "talkId": talkId,
      });

      return fetchQuestionsByTalkId(talkId);
    } on UnoError {
      return QuestionsFailure('Question creation error');
    }
  }

  @override
  Future<QuestionsState> deleteQuestion(int id, int talkId) async {
    try {
      await uno.delete('/questions/$id');
      return fetchQuestionsByTalkId(talkId);
    } on UnoError {
      return QuestionsFailure('Question deletion error');
    }
  }

  @override
  Future<QuestionsState> likeQuestion(int id, int talkId) async {
    try {
      await uno.get('/questions/like/$id');
      return fetchQuestionsByTalkId(talkId);
    } on UnoError {
      return QuestionsFailure('Question like error');
    }
  }

  @override
  Future<QuestionsState> unlikeQuestion(int id, int talkId) async {
    try {
      await uno.get('/questions/unlike/$id');
      return fetchQuestionsByTalkId(talkId);
    } on UnoError {
      return QuestionsFailure('Question unlike error');
    }
  }
}
