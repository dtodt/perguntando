import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/features/conferences/interactor/atoms/atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/question_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/talk_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/states/questions_state.dart';
import 'package:perguntando/src/features/conferences/ui/widgets/question_card_widget.dart';
import 'package:perguntando/src/features/conferences/ui/widgets/question_create_widget.dart';
import 'package:perguntando/src/shared/widgets/failure_widget.dart';
import 'package:perguntando/src/shared/widgets/loading_widget.dart';

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
      body = const LoadingWidget();
    } else if (state is QuestionsFailure) {
      body = FailureWidget(
        message: state.message,
        onTap: fetchQuestionsByTalkAction.call,
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
        key: const Key('QuestionsSuccess'),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return switch (list.elementAt(index)) {
            QuestionTitleEntity question => questionTitle(question),
            QuestionEntryEntity question => questionCard(question),
            QuestionCreateEntity _ => questionInput(),
          };
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

  Widget questionCard(QuestionEntryEntity question) {
    return QuestionCardWidget(
      key: Key('QuestionCardWidget${question.id}'),
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

  Widget questionInput() {
    return QuestionCreateWidget(
      onSubmit: (text) {
        addQuestionAction.setValue((
          text: text,
          talkId: widget.talk.id,
        ));
      },
    );
  }

  Widget questionTitle(QuestionTitleEntity question) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            question.title,
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 4.0),
          Text(
            question.subtitle,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
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
