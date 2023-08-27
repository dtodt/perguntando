import 'dart:async';

import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:perguntando/src/features/auth/interactor/atoms/auth_atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/atoms/atoms.dart';
import 'package:perguntando/src/features/conferences/interactor/entities/conference_entity.dart';
import 'package:perguntando/src/features/conferences/interactor/states/conferences_state.dart';
import 'package:perguntando/src/features/conferences/ui/widgets/conference_card_widget.dart';

class ConferencesPage extends StatefulWidget {
  const ConferencesPage({super.key});

  @override
  State<ConferencesPage> createState() => _ConferencesPageState();
}

class _ConferencesPageState extends State<ConferencesPage> {
  @override
  Widget build(BuildContext context) {
    final state = context.select(() => conferencesState.value);
    final theme = Theme.of(context);

    Widget body = const SizedBox();
    if (state is ConferencesLoading) {
      body = const Center(
        key: Key('ConferencesLoading'),
        child: CircularProgressIndicator(),
      );
    } else if (state is ConferencesFailure) {
      body = Center(
        key: const Key('ConferencesFailure'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(state.message),
            ElevatedButton(
              onPressed: fetchAllConferencesAction.call,
              child: const Text('Tentar novamente'),
            )
          ],
        ),
      );
    } else if (state is ConferencesSuccess) {
      final list = state.conferences.toList();
      list.insert(0, ConferenceTitleEntity(title: 'Eventos'));

      body = ListView.builder(
        key: const Key('ConferencesSuccess'),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final conference = list[index];
          return switch (conference) {
            ConferenceEntryEntity conference => ConferenceCardWidget(
                key: ValueKey('ConferenceCardWidget$index'),
                entity: conference,
                onTap: () {
                  Modular.to.pushNamed('./tasks', arguments: conference);
                },
              ),
            ConferenceTitleEntity _ => Padding(
                padding: const EdgeInsets.only(left: 4.0, bottom: 20.0),
                child: Text(
                  conference.title,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
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

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(fetchAllConferencesAction.call);
  }
}
