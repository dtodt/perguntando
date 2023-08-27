import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:perguntando/src/features/conferences/interactor/atoms/atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/question_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/talk_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/states/questions_state.dart';
import 'package:perguntando/src/features/conferences/ui/pages/questions_page.dart';
import 'package:perguntando/src/features/conferences/ui/widgets/question_card_widget.dart';
import 'package:perguntando/src/features/conferences/ui/widgets/question_create_widget.dart';

import '../../../../mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  tearDown(() => reset(navigate));

  testWidgets('QuestionsPage', (tester) async {
    when(
      () => navigate.pushNamed(any(), arguments: any(named: 'arguments')),
    ).thenAnswer((_) async => null);

    final talk = TalkEntryEntity(
      id: 1,
      description: 'description',
      imageUrl: 'imageUrl',
      speaker: 'speaker',
    );

    await mockNetworkImages(() async {
      await tester.pumpWidget(RxRoot(
        child: MaterialApp(
          home: QuestionsPage(talk: talk),
        ),
      ));

      questionsState.value = QuestionsLoading();
      await tester.pump();

      expect(find.byKey(const Key('QuestionsLoading')), findsOneWidget);

      questionsState.value = QuestionsFailure('Error');
      await tester.pump();

      expect(find.byKey(const Key('QuestionsFailure')), findsOneWidget);

      final question = QuestionEntryEntity(
        id: 1,
        profileImage: 'profileImage',
        profileName: 'profileName',
        text: 'text',
        likes: 0,
        isLikedForMe: false,
        isMine: true,
      );
      questionsState.value = QuestionsSuccess([question]);
      await tester.pump();
      expect(find.byKey(const Key('QuestionsSuccess')), findsOneWidget);

      final createFinder = find.byType(QuestionCreateWidget);
      final inputFinder =
          find.descendant(of: createFinder, matching: find.byType(TextField));
      await tester.enterText(inputFinder, 'text');
      await tester.pump();

      final submitFinder =
          find.descendant(of: createFinder, matching: find.byIcon(Icons.send));
      await tester.tap(submitFinder);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      final cardFinder = find.byType(QuestionCardWidget).first;

      expect(likeQuestionAction.next(), completes);
      final likeFinder = find.descendant(
          of: cardFinder, matching: find.byIcon(Icons.favorite_border));
      await tester.tap(likeFinder);
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(removeQuestionAction.next(), completes);
      final removeFinder = find.descendant(
          of: cardFinder, matching: find.byIcon(Icons.delete_outline_rounded));
      await tester.tap(removeFinder);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    });
  });
}
