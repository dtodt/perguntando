import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:perguntando/src/features/conferences/interactor/atoms/atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/conference_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/question_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/talk_entity.dart';

import 'package:perguntando/src/features/conferences/interactor/reducers/conferences_reducer.dart';
import 'package:perguntando/src/features/conferences/interactor/services/conferences_service.dart';
import 'package:perguntando/src/features/conferences/interactor/states/conferences_state.dart';
import 'package:perguntando/src/features/conferences/interactor/states/questions_state.dart';
import 'package:perguntando/src/features/conferences/interactor/states/talks_state.dart';

class ConferencesServiceMock extends Mock implements ConferencesService {}

void main() {
  final service = ConferencesServiceMock();
  final reducer = ConferencesReducer(service);

  tearDown(() => reset(service));
  tearDownAll(() => reducer.dispose());

  test('fetchAllConferences', () async {
    when(() => service.fetchAllConferences())
        .thenAnswer((_) async => ConferencesSuccess([]));

    expect(
      conferencesState.buffer(2),
      completion([
        isA<ConferencesLoading>(),
        isA<ConferencesSuccess>(),
      ]),
    );

    fetchAllConferencesAction();
  });

  test('fetchTalksByConferenceId', () async {
    when(() => service.fetchTalksByConferenceId(1))
        .thenAnswer((_) async => TalksSuccess([]));

    expect(
      talksState.buffer(2),
      completion([
        isA<TalksLoading>(),
        isA<TalksSuccess>(),
      ]),
    );

    fetchTalksByConferenceAction.value = ConferenceEntryEntity(
      id: 1,
      title: 'title',
      imageUrl: 'imageUrl',
    );
  });

  test('fetchQuestionsByTalkId', () async {
    when(() => service.fetchQuestionsByTalkId(1))
        .thenAnswer((_) async => QuestionsSuccess([]));

    expect(
      questionsState.buffer(2),
      completion([
        isA<QuestionsLoading>(),
        isA<QuestionsSuccess>(),
      ]),
    );

    fetchQuestionsByTalkAction.value = TalkEntryEntity(
      id: 1,
      speaker: "speaker",
      description: "description",
      imageUrl: "imageUrl",
    );
  });

  test('addQuestion', () async {
    when(() => service.createQuestion('Question', 1))
        .thenAnswer((_) async => QuestionsSuccess([]));

    expect(
      questionsState.next(),
      completion(isA<QuestionsSuccess>()),
    );

    addQuestionAction.setValue((talkId: 1, text: 'Question'));
  });

  group('likeQuestion |', () {
    test('should mark as liked', () async {
      when(() => service.likeQuestion(1, 1))
          .thenAnswer((_) async => QuestionsSuccess([]));
      questionsState.setValue(QuestionsSuccess([
        QuestionEntryEntity(
          id: 1,
          profileImage: 'profileImage',
          profileName: 'profileName',
          text: 'text',
          likes: 0,
          isLikedForMe: false,
          isMine: true,
        )
      ]));

      expect(
        questionsState.buffer(2),
        completion([
          isA<QuestionsSuccess>(),
          isA<QuestionsSuccess>(),
        ]),
      );

      likeQuestionAction.setValue((talkId: 1, questionId: 1, isLiked: true));
    });

    test('should unmark as liked', () async {
      when(() => service.unlikeQuestion(1, 1))
          .thenAnswer((_) async => QuestionsSuccess([]));
      questionsState.setValue(QuestionsSuccess([
        QuestionEntryEntity(
          id: 1,
          profileImage: 'profileImage',
          profileName: 'profileName',
          text: 'text',
          likes: 0,
          isLikedForMe: true,
          isMine: true,
        )
      ]));

      expect(
        questionsState.buffer(2),
        completion([
          isA<QuestionsSuccess>(),
          isA<QuestionsSuccess>(),
        ]),
      );

      likeQuestionAction.setValue((talkId: 1, questionId: 1, isLiked: false));
    });
  });

  test('removeQuestion', () async {
    when(() => service.deleteQuestion(1, 1))
        .thenAnswer((_) async => QuestionsSuccess([]));

    expect(
      questionsState.next(),
      completion(isA<QuestionsSuccess>()),
    );

    removeQuestionAction.setValue((talkId: 1, questionId: 1));
  });
}
