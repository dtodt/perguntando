import 'package:flutter/material.dart';
import 'package:perguntando/src/shared/widgets/logo.dart';
import 'package:sign_button/sign_button.dart';

import '../../interactor/dtos/email_credential.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var dto = EmailCredentialDTO();

  @override
  Widget build(BuildContext context) {
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
              onPressed: () {},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(height: 12.0),
            SignInButton(
              buttonSize: ButtonSize.large,
              buttonType: ButtonType.appleDark,
              onPressed: () {},
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
