import 'package:flutter/material.dart';
import 'package:formulaire_exemple/api/controller/api_controller.dart';
import 'package:formulaire_exemple/api/widgets/register_form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => RegisterFormState();
}

class RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final _lastNameController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreeToTerms = false;
  final ApiController controller = ApiController();

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RegisterFormField(
              controller: _lastNameController,
              label: 'Nom',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre nom';
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'Veuillez n\'utiliser que des lettres';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            RegisterFormField(
              controller: _firstNameController,
              label: 'Prénom',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer votre prénom';
                } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                  return 'Veuillez n\'utiliser que des lettres';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            RegisterFormField(
              controller: _emailController,
              label: 'Email',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un email';
                } else if (!RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value)) {
                  return 'Veuillez entrer un email valide';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            RegisterFormField(
              controller: _passwordController,
              label: 'Mot de passe',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez entrer un mot de passe';
                }
                if (value.length < 12) {
                  return 'Le mot de passe doit contenir au moins 12 caractères';
                }
                if (!RegExp(r'(?=.*[a-z])').hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins une minuscule';
                }
                if (!RegExp(r'(?=.*[A-Z])').hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins une majuscule';
                }
                if (!RegExp(r'(?=.*\d)').hasMatch(value)) {
                  return 'Le mot de passe doit contenir au moins un chiffre';
                }
                if (!RegExp(r'(?=.*\W)').hasMatch(value)) {
                  // \W signifie tout caractère qui n'est pas une lettre ou un chiffre
                  return 'Le mot de passe doit contenir au moins un caractère spécial';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            RegisterFormField(
              controller: _confirmPasswordController,
              label: 'Confirmez le mot de passe',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez confirmer votre mot de passe';
                } else if (value != _passwordController.text) {
                  return 'Les mots de passe ne correspondent pas';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            CheckboxListTile(
              title: const Text('Accepter les termes et conditions'),
              value: _agreeToTerms,
              onChanged: (bool? newValue) {
                setState(() {
                  _agreeToTerms = newValue!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                _agreeToTerms
                    ? await controller.submitForm(
                        _formKey,
                        context,
                        _firstNameController.text,
                        _lastNameController.text,
                        _emailController.text,
                        _passwordController.text,
                      )
                    : null;
              },
              child: const Center(child: Text('S\'inscrire')),
            ),
          ],
        ),
      ),
    );
  }
}
