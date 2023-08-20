import 'package:asp/asp.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/conference_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/talk_entity.dart';

import '../states/conferences_state.dart';
import '../states/questions_state.dart';
import '../states/talks_state.dart';

final conferencesState = Atom<ConferencesState>(
  ConferencesInitial(),
  key: 'conferencesState',
);

final talksState = Atom<TalksState>(
  TalksInitial(),
  key: 'talksState',
);

final questionsState = Atom<QuestionsState>(
  QuestionsInitial(),
  key: 'questionsState',
);

final fetchAllConferencesAction = Atom.action(
  key: 'fetchAllConferencesAction',
);

final fetchTalksByConferenceAction = Atom<ConferenceEntryEntity?>(
  null,
  key: 'fetchTalksByConferenceAction',
);

final fetchQuestionsByTalkAction = Atom<TalkEntryEntity?>(
  null,
  key: 'fetchQuestionsByTalkAction',
);

final likeQuestionAction = Atom<LikeDTO?>(
  null,
  key: 'likeQuestionAction',
  pipe: debounceTime(const Duration(seconds: 1)),
);

final executeLikeQuestionAction = Atom<LikeDTO?>(
  null,
  key: 'executeLikeQuestionAction',
  pipe: debounceTime(const Duration(seconds: 1)),
);

final addQuestionAction = Atom<AddQuestionDTO?>(
  null,
  key: 'addQuestionAction',
  pipe: debounceTime(const Duration(seconds: 1)),
);

final removeQuestionAction = Atom<RemoveQuestionDTO?>(
  null,
  key: 'removeQuestionAction',
  pipe: debounceTime(const Duration(seconds: 1)),
);

typedef LikeDTO = ({int questionId, int talkId, bool isLiked});
typedef AddQuestionDTO = ({String text, int talkId});
typedef RemoveQuestionDTO = ({int questionId, int talkId});
