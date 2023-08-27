import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perguntando/src/features/conferences/data/services/uno_conferences_service.dart';
import 'package:perguntando/src/features/conferences/interactor/services/conferences_service.dart';
import 'package:perguntando/src/features/conferences/interactor/states/conferences_state.dart';
import 'package:perguntando/src/features/conferences/interactor/states/questions_state.dart';
import 'package:perguntando/src/features/conferences/interactor/states/talks_state.dart';
import 'package:uno/uno.dart';

import '../../../../mocks.dart';

void main() {
  final auth = FirebaseAuthMock();
  final response = ResponseMock();
  final uno = UnoMock();
  final user = UserMock();
  final ConferencesService service = UnoConferencesService(uno, auth);

  tearDown(() {
    reset(auth);
    reset(response);
    reset(uno);
    reset(user);
  });

  group('fetchAllConferences |', () {
    test('should return success', () async {
      when(() => response.data).thenReturn(conferenceSuccessJson);
      when(() => uno.get('/conferences')).thenAnswer((_) async => response);

      final result = await service.fetchAllConferences();
      expect(result, isA<ConferencesSuccess>());
    });

    test('should return failure', () async {
      when(() => uno.get('/conferences')).thenThrow(const UnoError('error'));

      final result = await service.fetchAllConferences();
      expect(result, isA<ConferencesFailure>());
    });
  });

  group('fetchTalksByConferenceId |', () {
    test('should return success', () async {
      when(() => response.data).thenReturn(talkSuccessJson);
      when(() => uno.get('/talks/1')).thenAnswer((_) async => response);

      final result = await service.fetchTalksByConferenceId(1);
      expect(result, isA<TalksSuccess>());
    });

    test('should return failure', () async {
      when(() => uno.get('/talks/1')).thenThrow(const UnoError('error'));

      final result = await service.fetchTalksByConferenceId(1);
      expect(result, isA<TalksFailure>());
    });
  });

  group('fetchQuestionsByTalkId |', () {
    test('should return success', () async {
      when(() => auth.currentUser).thenReturn(user);
      when(() => response.data).thenReturn(questionSuccessJson);
      when(() => uno.get('/questions/1')).thenAnswer((_) async => response);
      when(() => user.uid).thenReturn('uid');

      final result = await service.fetchQuestionsByTalkId(1);
      expect(result, isA<QuestionsSuccess>());
    });

    test('should return failure', () async {
      when(() => auth.currentUser).thenReturn(user);
      when(() => uno.get('/questions/1')).thenThrow(const UnoError('error'));
      when(() => user.uid).thenReturn('uid');

      final result = await service.fetchQuestionsByTalkId(1);
      expect(result, isA<QuestionsFailure>());
    });
  });

  group('createQuestion |', () {
    test('should return success', () async {
      when(() => auth.currentUser).thenReturn(user);
      when(() => response.data).thenReturn(questionSuccessJson);
      when(() => uno.get('/questions/1')).thenAnswer((_) async => response);
      when(() => user.displayName).thenReturn('displayName');
      when(() => user.photoURL).thenReturn('photoURL');
      when(() => user.uid).thenReturn('uid');

      when(() => uno.post('/questions', data: any(named: 'data')))
          .thenAnswer((_) async => response);

      final result = await service.createQuestion('Question', 1);
      expect(result, isA<QuestionsSuccess>());
    });

    test('should return failure', () async {
      when(() => auth.currentUser).thenReturn(user);
      when(() => user.displayName).thenReturn('displayName');
      when(() => user.photoURL).thenReturn('photoURL');
      when(() => user.uid).thenReturn('uid');
      when(() => uno.post('/questions', data: any(named: 'data')))
          .thenThrow(const UnoError('error'));

      final result = await service.createQuestion('Question', 1);
      expect(result, isA<QuestionsFailure>());
    });
  });

  group('deleteQuestion |', () {
    test('should return success', () async {
      when(() => auth.currentUser).thenReturn(user);
      when(() => response.data).thenReturn(questionSuccessJson);
      when(() => uno.get('/questions/1')).thenAnswer((_) async => response);
      when(() => user.uid).thenReturn('uid');

      when(() => uno.delete('/questions/1')).thenAnswer((_) async => response);

      final result = await service.deleteQuestion(1, 1);
      expect(result, isA<QuestionsSuccess>());
    });

    test('should return failure', () async {
      when(() => uno.delete('/questions/1')).thenThrow(const UnoError('error'));

      final result = await service.deleteQuestion(1, 1);
      expect(result, isA<QuestionsFailure>());
    });
  });

  group('likeQuestion |', () {
    test('should return success', () async {
      when(() => auth.currentUser).thenReturn(user);
      when(() => response.data).thenReturn(questionSuccessJson);
      when(() => uno.get('/questions/1')).thenAnswer((_) async => response);
      when(() => user.uid).thenReturn('uid');

      when(() => uno.get('/questions/like/1'))
          .thenAnswer((_) async => response);

      final result = await service.likeQuestion(1, 1);
      expect(result, isA<QuestionsSuccess>());
    });

    test('should return failure', () async {
      when(() => uno.get('/questions/like/1'))
          .thenThrow(const UnoError('error'));

      final result = await service.likeQuestion(1, 1);
      expect(result, isA<QuestionsFailure>());
    });
  });

  group('unlikeQuestion |', () {
    test('should return success', () async {
      when(() => auth.currentUser).thenReturn(user);
      when(() => response.data).thenReturn(questionSuccessJson);
      when(() => uno.get('/questions/1')).thenAnswer((_) async => response);
      when(() => user.uid).thenReturn('uid');

      when(() => uno.get('/questions/unlike/1'))
          .thenAnswer((_) async => response);

      final result = await service.unlikeQuestion(1, 1);
      expect(result, isA<QuestionsSuccess>());
    });

    test('should return failure', () async {
      when(() => uno.get('/questions/unlike/1'))
          .thenThrow(const UnoError('error'));

      final result = await service.unlikeQuestion(1, 1);
      expect(result, isA<QuestionsFailure>());
    });
  });
}

const conferenceSuccessJson = [
  {
    "id": 1,
    "imageUrl": "url",
    "title": "title",
  },
];

const talkSuccessJson = [
  {
    "id": 1,
    "description": "description",
    "speaker": "speaker",
    "speakerImage": "speakerImage",
  },
];

const questionSuccessJson = [
  {
    "id": 1,
    "userId": "userId",
    "name": "name",
    "imageUrl": "imageUrl",
    "text": "text",
    "talkId": 1,
    "likes": [
      {
        "id": 1,
        "questionId": 1,
        "userId": "uid",
      },
    ],
  },
];
