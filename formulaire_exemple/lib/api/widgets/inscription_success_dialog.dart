import 'package:flutter/material.dart';

class InscriptionSuccessDialog extends StatelessWidget {
  final String firstName;
  final String lastName;

  const InscriptionSuccessDialog({super.key, required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AlertDialog(
      title: const Text('Inscription réussie'),
      content: Text(
          'Bonjour, $firstName $lastName!'),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () => {
            Navigator.of(context).pop(),
            Navigator.of(context).pushReplacementNamed('/')
          },
        ),
      ],
    );
  }
}