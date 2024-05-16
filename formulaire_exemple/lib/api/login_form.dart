import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:formulaire_exemple/api/user.dart';
import 'package:formulaire_exemple/providers/auth_provider.dart';
import 'package:formulaire_exemple/utils/secure_storage.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final SecureStorage secureStorage = SecureStorage();

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  Future<void> _loadCredentials() async {
    final credentials = await secureStorage.readCredentials();
    setState(() {
      _emailController.text = credentials['email'] ?? '';
      _passwordController.text = credentials['password'] ?? '';
    });
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response =
          await login(_emailController.text, _passwordController.text);
      final responseData = json.decode(response.body);

      await secureStorage.saveCredentials(
        _emailController.text,
        _passwordController.text,
        responseData['user']['firstName'],
        responseData['user']['lastName'],
      );

      await secureStorage.saveToken(responseData['token']);

      Provider.of<AuthProvider>(context, listen: false).login();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Authentification réussie')),
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(
          context,
          '/',
        );
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Echec de l\'authentification $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre email';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Entrez votre mot de passe';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await _login();
                    }
                  },
                  child: const Text('Login'),
                ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
