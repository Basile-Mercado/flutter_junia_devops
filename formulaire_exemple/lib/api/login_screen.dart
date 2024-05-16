import 'package:flutter/material.dart';
import 'package:formulaire_exemple/api/login_form.dart';
import 'package:formulaire_exemple/global_widget/scaffold.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlobalScaffold(
      shouldDisplayTopBar: false,
      name: 'Login',
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
