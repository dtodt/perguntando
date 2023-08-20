import 'package:flutter_modular/flutter_modular.dart';
import 'package:perguntando/src/features/conferences/ui/pages/questions_page.dart';
import 'package:perguntando/src/features/conferences/ui/pages/talks_page.dart';

import 'data/services/uno_conferences_service.dart';
import 'interactor/reducers/conferences_reducer.dart';
import 'interactor/services/conferences_service.dart';
import 'ui/pages/conferences_page.dart';

class ConferencesModule extends Module {
  @override
  void binds(Injector i) {
    i.add<ConferencesService>(UnoConferencesService.new);
    i.addSingleton(ConferencesReducer.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (_) => const ConferencesPage());
    r.child('/tasks', child: (_) => TalksPage(conference: r.args.data));
    r.child('/questions', child: (_) => QuestionsPage(talk: r.args.data));
  }
}
