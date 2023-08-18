import 'package:asp/asp.dart';
import 'package:flutter/material.dart';

import '../../interactor/atoms/auth_atoms.dart';
import '../../interactor/dtos/email_credential.dart';
import '../../interactor/states/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var dto = EmailCredentialDTO();

  @override
  Widget build(BuildContext context) {
    final state = context.select(() => authState.value);
    final isLoading = state is LoadingAuth;

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.2),
            Text(
              'Things',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 40),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              enabled: !isLoading,
              onChanged: (value) {
                dto.email = value;
              },
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              enabled: !isLoading,
              obscureText: true,
              onChanged: (value) {
                dto.password = value;
              },
              textInputAction: TextInputAction.send,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      loginWithEmailAction.value = dto;
                    },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
