import 'package:flutter/material.dart';
import 'package:formulaire_exemple/api/register_form.dart';
import 'package:formulaire_exemple/global_widget/scaffold.dart';
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return _RegisterScreen();
  }
}
class _RegisterScreen extends State<RegisterScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return const GlobalScaffold(
      shouldDisplayTopBar: false,
      body: RegisterForm(),
      name: 'Register',
    );
  }
}
