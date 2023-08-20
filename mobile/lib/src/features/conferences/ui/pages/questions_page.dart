import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/features/conferences/interactor/atoms/atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/question_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/talk_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/states/questions_state.dart';
import 'package:perguntando/src/features/conferences/ui/widgets/question_card_widget.dart';
import 'package:perguntando/src/features/conferences/ui/widgets/question_create_widget.dart';

class QuestionsPage extends StatefulWidget {
  final TalkEntryEntity talk;
  const QuestionsPage({super.key, required this.talk});

  @override
  State<QuestionsPage> createState() => _QuestionsPageState();
}

class _QuestionsPageState extends State<QuestionsPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.select(() => questionsState.value);

    Widget body = const SizedBox();
    if (state is QuestionsLoading) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is QuestionsFailure) {
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.message),
            ElevatedButton(
              onPressed: fetchQuestionsByTalkAction.call,
              child: const Text('Tentar novamente'),
            )
          ],
        ),
      );
    } else if (state is QuestionsSuccess) {
      final list = state.questions.toList();
      list.insert(
        0,
        QuestionCreateEntity(),
      );
      list.insert(
        0,
        QuestionTitleEntity(
          title: widget.talk.description,
          subtitle: 'por ${widget.talk.speaker}',
        ),
      );

      body = ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final question = list[index];
          if (question is QuestionCreateEntity) {
            return QuestionCreateWidget(onSubmit: (text) {
              addQuestionAction.setValue((
                text: text,
                talkId: widget.talk.id,
              ));
            });
          }
          if (question is QuestionEntryEntity) {
            return QuestionCardWidget(
              entity: question,
              onLike: () {
                likeQuestionAction.setValue((
                  questionId: question.id,
                  talkId: widget.talk.id,
                  isLiked: !question.isLikedForMe,
                ));
              },
              onRemove: () {
                removeQuestionAction.setValue((
                  questionId: question.id,
                  talkId: widget.talk.id,
                ));
              },
            );
          }
          if (question is QuestionTitleEntity) {
            return Text(question.title);
          }
          return null;
        },
        padding: const EdgeInsets.only(left: 15, right: 15),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntando'),
      ),
      body: body,
    );
  }

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(
      () => fetchQuestionsByTalkAction.setValue(widget.talk),
    );
  }
}
