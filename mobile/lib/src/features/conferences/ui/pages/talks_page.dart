import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:perguntando/src/features/conferences/interactor/atoms/atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/conference_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/talk_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/states/talks_state.dart';
import 'package:perguntando/src/features/conferences/ui/widgets/talk_card_widget.dart';

class TalksPage extends StatefulWidget {
  final ConferenceEntryEntity conference;
  const TalksPage({super.key, required this.conference});

  @override
  State<TalksPage> createState() => _TalksPageState();
}

class _TalksPageState extends State<TalksPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.select(() => talksState.value);

    Widget body = const SizedBox();
    if (state is TalksLoading) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is TalksFailure) {
      body = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.message),
            ElevatedButton(
              onPressed: fetchTalksByConferenceAction.call,
              child: const Text('Tentar novamente'),
            )
          ],
        ),
      );
    } else if (state is TalksSuccess) {
      final list = state.talks.toList();
      list.insert(
        0,
        TalkTitleEntity(title: 'Palestras', subtitle: widget.conference.title),
      );

      body = ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          final talk = list[index];
          if (talk is TalkEntryEntity) {
            return TalkCardWidget(
              entity: talk,
              onTap: () {
                Modular.to.pushNamed('./questions', arguments: talk);
              },
            );
          }
          if (talk is TalkTitleEntity) {
            return Text(talk.title);
          }
          return null;
        },
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
      () => fetchTalksByConferenceAction.setValue(widget.conference),
    );
  }
}
