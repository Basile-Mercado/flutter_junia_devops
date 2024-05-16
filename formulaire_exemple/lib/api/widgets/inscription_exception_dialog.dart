import 'package:flutter/material.dart';

class InscriptionExceptionDialog extends StatelessWidget {
  final Object e;

  const InscriptionExceptionDialog({super.key, required this.e});


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Erreur'),
      content: Text('Erreur lors de l\'inscription: $e'),
      actions: <Widget>[
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}