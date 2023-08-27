import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:perguntando/src/shared/widgets/logo_widget.dart';
import 'package:sign_button/sign_button.dart';

import '../../interactor/atoms/auth_atoms.dart';
import '../../interactor/states/auth_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            const LogoWidget(),
            const SizedBox(height: 80.0),
            SignInButton(
              buttonSize: ButtonSize.large,
              buttonType: ButtonType.google,
              onPressed: isLoading ? null : loginWithGoogleAction.call,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(height: 12.0),
            SignInButton(
              buttonSize: ButtonSize.large,
              buttonType: ButtonType.appleDark,
              onPressed: isLoading ? null : loginWithAppleAction.call,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
