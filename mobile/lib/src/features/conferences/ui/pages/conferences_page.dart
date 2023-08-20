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

    Widget body = const SizedBox();
    if (state is ConferencesLoading) {
      body = const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is ConferencesFailure) {
      body = Center(
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
        itemCount: list.length,
        itemBuilder: (context, index) {
          final conference = list[index];
          if (conference is ConferenceEntryEntity) {
            return ConferenceCardWidget(
              entity: conference,
              onTap: () {
                Modular.to.pushNamed('./tasks', arguments: conference);
              },
            );
          }
          if (conference is ConferenceTitleEntity) {
            return Text(conference.title);
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
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
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
