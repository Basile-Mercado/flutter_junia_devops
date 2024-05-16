import 'package:flutter/material.dart';
import 'package:formulaire_exemple/api/user.dart';
import 'package:formulaire_exemple/api/widgets/inscription_exception_dialog.dart';
import 'package:formulaire_exemple/api/widgets/inscription_failure_dialog.dart';
import 'package:formulaire_exemple/api/widgets/inscription_success_dialog.dart';

class ApiController {
  Future submitForm(
    GlobalKey<FormState> formKey,
    BuildContext context,
    String firstname,
    String lastname,
    String email,
    String password,
  ) async {
    if (formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()),
      );
      try {
        int result = await registerUser(
          firstname,
          lastname,
          email,
          password,
        );
        Navigator.of(context).pop();
        if (result == 201) {
          showDialog(
            context: context,
            builder: (context) => InscriptionSuccessDialog(
              firstName: firstname,
              lastName: lastname,
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => InscriptionFailureDialog(result: result),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => InscriptionExceptionDialog(e: e),
        );
      }
    } else {
      return;
    }
  }
}
