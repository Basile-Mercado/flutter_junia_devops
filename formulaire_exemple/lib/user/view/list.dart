import 'package:flutter/material.dart';
import 'package:formulaire_exemple/message/controller/message_controller.dart';
import 'package:formulaire_exemple/message/model/message.dart';
import 'package:formulaire_exemple/user/model/user.dart';
import 'package:formulaire_exemple/user/controller/user_controller.dart';
import 'package:formulaire_exemple/user/view/user_dialog.dart';
import 'package:formulaire_exemple/user/view/user_page.dart';

class ListExemple extends StatefulWidget {
  const ListExemple({super.key});

  @override
  State<StatefulWidget> createState() => ListExempleState();
}

class ListExempleState extends State<ListExemple> {
  UserController controller = UserController();
  MessageController msg = MessageController();

  @override
  void initState() {
    super.initState();
    controller.loadUsers().then((value) => msg.loadMessages(controller.users));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemple de ListView'),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: controller.users.length,
            (context, index) {
              User user = controller.users[index];
              Message message = msg.messages[index];
              return Dismissible(
                key: Key(user.nom),
                direction: DismissDirection.startToEnd,
                onDismissed: (direction) {
                  controller.users.removeAt(index);
                  setState(() {});
                  if (!controller.users.contains(user)) {
                    const snack = SnackBar(
                        content: Text('Utilisateur supprimé de la liste'));
                    ScaffoldMessenger.of(context).showSnackBar(snack);
                  }
                },
                child: ListTile(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => UserPage(
                        user: user,
                        messages: [message],
                      ),
                    ),
                  ),
                  leading: const Icon(Icons.person),
                  title: Text('Nom: ${user.nom} | Prénom: ${user.prenom}'),
                ),
              );
            }
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final User add = await showDialog(
              context: context,
              builder: (context) => UserDialog(users: controller.users),
            );
            if (controller.users.contains(add)) {
              setState(() {});
            }
          },
          child: const Icon(Icons.add)),
    );
  }
}
