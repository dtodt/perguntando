import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:perguntando/src/features/conferences/interactor/atoms/atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/conference_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/states/conferences_state.dart';
import 'package:perguntando/src/features/conferences/ui/pages/conferences_page.dart';

class ModularNavigateMock extends Mock implements IModularNavigator {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final navigate = ModularNavigateMock();
  Modular.navigatorDelegate = navigate;

  testWidgets('ConferencesPage', (tester) async {
    when(() => navigate.pop(any())).thenAnswer((_) async {});
    when(
      () => navigate.pushNamed(any(), arguments: any(named: 'arguments')),
    ).thenAnswer((_) async => null);

    await mockNetworkImages(() async {
      await tester.pumpWidget(const RxRoot(
        child: MaterialApp(
          home: ConferencesPage(),
        ),
      ));

      conferencesState.value = ConferencesLoading();
      await tester.pump();

      expect(find.byKey(const Key('ConferencesLoading')), findsOneWidget);

      conferencesState.value = ConferencesFailure('Error');
      await tester.pump();

      expect(find.byKey(const Key('ConferencesFailure')), findsOneWidget);

      final conference = ConferenceEntryEntity(
        id: 1,
        title: 'title',
        imageUrl: 'imageUrl',
      );
      conferencesState.value = ConferencesSuccess([conference]);
      await tester.pump();

      expect(find.byKey(const Key('ConferencesSuccess')), findsOneWidget);

      final itemFinder = find.byKey(const ValueKey('ConferenceCardWidget1'));
      expect(itemFinder, findsOneWidget);

      await tester.tap(itemFinder);
      await tester.pump();

      verify(
        () => navigate.pushNamed(any(), arguments: any(named: 'arguments')),
      );

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('LogoutButton')));
    });
  });
}
