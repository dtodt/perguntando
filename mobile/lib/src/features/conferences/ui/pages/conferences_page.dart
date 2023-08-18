import 'package:flutter/material.dart';
import 'package:perguntando/src/features/auth/interactor/atoms/auth_atoms.dart';

class ConferencesPage extends StatefulWidget {
  const ConferencesPage({super.key});

  @override
  State<ConferencesPage> createState() => _ConferencesPageState();
}

class _ConferencesPageState extends State<ConferencesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Things'),
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
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
    );
  }
}