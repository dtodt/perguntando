import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:perguntando/src/features/conferences/interactor/atoms/atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/conference_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/talk_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/states/talks_state.dart';
import 'package:perguntando/src/features/conferences/ui/pages/talks_page.dart';

import '../../../../mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  tearDown(() => reset(navigate));

  testWidgets('TalksPage', (tester) async {
    when(() => navigate.pop(any())).thenAnswer((_) async {});
    when(
      () => navigate.pushNamed(any(), arguments: any(named: 'arguments')),
    ).thenAnswer((_) async => null);

    final conference = ConferenceEntryEntity(
      id: 1,
      title: 'title',
      imageUrl: 'imageUrl',
    );

    await mockNetworkImages(() async {
      await tester.pumpWidget(RxRoot(
        child: MaterialApp(
          home: TalksPage(conference: conference),
        ),
      ));

      talksState.value = TalksLoading();
      await tester.pump();

      expect(find.byKey(const Key('TalksLoading')), findsOneWidget);

      talksState.value = TalksFailure('Error');
      await tester.pump();

      expect(find.byKey(const Key('TalksFailure')), findsOneWidget);

      final talk = TalkEntryEntity(
        id: 1,
        description: 'description',
        imageUrl: 'imageUrl',
        speaker: 'speaker',
      );
      talksState.value = TalksSuccess([talk]);
      await tester.pump();

      expect(find.byKey(const Key('TalksSuccess')), findsOneWidget);

      final itemFinder = find.byKey(const ValueKey('TalkCardWidget1'));
      expect(itemFinder, findsOneWidget);

      await tester.tap(itemFinder);
      await tester.pump();

      verify(
        () => navigate.pushNamed(any(), arguments: any(named: 'arguments')),
      );
    });
  });
}
