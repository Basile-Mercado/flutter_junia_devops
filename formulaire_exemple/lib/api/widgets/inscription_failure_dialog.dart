import 'package:flutter/material.dart';

class InscriptionFailureDialog extends StatelessWidget {

   final int result;

  const InscriptionFailureDialog({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Échec de l\'inscription'),
      content: Text(
          'Une erreur est survenue: ${result.toString()}. Veuillez réessayer.'),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
