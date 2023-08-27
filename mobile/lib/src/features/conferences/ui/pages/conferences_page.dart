import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:perguntando/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/atoms/atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/conference_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/states/conferences_state.dart';
import 'package:perguntando/src/features/conferences/ui/widgets/conference_card_widget.dart';
import 'package:perguntando/src/shared/widgets/failure_widget.dart';
import 'package:perguntando/src/shared/widgets/loading_widget.dart';

class ConferencesPage extends StatefulWidget {
  const ConferencesPage({super.key});

  @override
  State<ConferencesPage> createState() => _ConferencesPageState();
}

class _ConferencesPageState extends State<ConferencesPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.select(() => conferencesState.value);

    Widget body = const SizedBox();
    if (state is ConferencesLoading) {
      body = const LoadingWidget();
    } else if (state is ConferencesFailure) {
      body = FailureWidget(
        message: state.message,
        onTap: fetchAllConferencesAction.call,
      );
    } else if (state is ConferencesSuccess) {
      final list = state.conferences.toList();
      list.insert(0, ConferenceTitleEntity(title: 'Eventos'));

      body = ListView.builder(
        key: const Key('ConferencesSuccess'),
        itemCount: list.length,
        itemBuilder: (context, index) {
          return switch (list.elementAt(index)) {
            ConferenceEntryEntity conference => conferenceCard(conference),
            ConferenceTitleEntity conference => conferenceTitle(conference),
          };
        },
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perguntando'),
      ),
      body: body,
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  key: const Key('LogoutButton'),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    logoutAction();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget conferenceCard(ConferenceEntryEntity conference) {
    return ConferenceCardWidget(
      key: Key('ConferenceCardWidget${conference.id}'),
      entity: conference,
      onTap: () {
        Modular.to.pushNamed('./tasks', arguments: conference);
      },
    );
  }

  Widget conferenceTitle(ConferenceTitleEntity conference) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(left: 4.0, bottom: 20.0),
      child: Text(
        conference.title,
        style: theme.textTheme.headlineSmall,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(fetchAllConferencesAction.call);
  }
}
