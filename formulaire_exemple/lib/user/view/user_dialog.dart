import 'package:flutter/material.dart';
import 'package:formulaire_exemple/user/model/user.dart';
import 'package:formulaire_exemple/user/controller/user_controller.dart';

class UserDialog extends StatefulWidget {
  final List<User> users;

  const UserDialog({super.key, required this.users});

  @override
  State<UserDialog> createState() => UserDialogState();
}

class UserDialogState extends State<UserDialog> {
  final UserController userController = UserController();
  late TextEditingController prenom;
  late TextEditingController nom;
  String addedFirstName = '';
  String addedName = '';

  @override
  void initState() {
    super.initState();
    prenom = TextEditingController();
    nom = TextEditingController();
  }

  @override
  void dispose() {
    prenom.dispose();
    nom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un utilisateur'),
      content: Column(
        children: [
          TextField(
            controller: nom,
            decoration: const InputDecoration(
              hintText: 'Entrez le nom de famille de l\'utilisateur',
            ),
            onChanged: (value) => setState(() {
              addedFirstName = value;
            }),
          ),
          TextField(
            controller: prenom,
            decoration: const InputDecoration(
              hintText: 'Entrez le prénom de l\'utilisateur',
            ),
            onChanged: (value) => setState(() {
              addedName = value;
            }),
          )
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if(addedFirstName == '' && addedName == ''){
              const snack = SnackBar(content: Text('Vous n\'avez pas remplis les champs'));
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return;
            }
            User user = User(nom: addedName, prenom: addedFirstName);
            widget.users.add(user);
            setState(() {});
            Navigator.of(context).pop(user);
            const snack = SnackBar(content: Text('Utilisateur ajouté dans la liste'));
            ScaffoldMessenger.of(context).showSnackBar(snack);
          },
          child: const Text('OK'),
        )
      ],
    );
  }
}
