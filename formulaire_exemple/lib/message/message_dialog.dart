import 'package:flutter/material.dart';
import 'package:formulaire_exemple/message/controller/message_controller.dart';
import 'package:formulaire_exemple/message/model/message.dart';
import 'package:formulaire_exemple/user/model/user.dart';

class MessageDialog extends StatefulWidget {
  final User user;
  final List<Message> messages;

  const MessageDialog({super.key, required this.messages, required this.user});

  @override
  State<MessageDialog> createState() => MessageDialogState();
}

class MessageDialogState extends State<MessageDialog> {
  final MessageController controller = MessageController();
  late TextEditingController subject;
  late TextEditingController content;
  String addedSubject = '';
  String addedContent = '';

  @override
  void initState() {
    super.initState();
    subject = TextEditingController();
    content = TextEditingController();
  }

  @override
  void dispose() {
    subject.dispose();
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Ajouter un message'),
      content: Column(
        children: [
          TextField(
            controller: subject,
            autocorrect: true,
            decoration: const InputDecoration(hintText: 'Sujet du message'),
            maxLength: 100,
            onChanged: (value) {
              setState(() {
                addedSubject = value;
              });
            },
          ),
          TextField(
            controller: content,
            autocorrect: true,
            decoration: const InputDecoration(hintText: 'Contenu du message'),
            onChanged: (value) {
              setState(() {
                addedContent = value;
              });
            },
          ),
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (addedSubject == '' && addedContent == '') {
                const snack = SnackBar(
                    content: Text('Vous n\'avez pas remplis les champs'));
                ScaffoldMessenger.of(context).showSnackBar(snack);
                return;
              }
              Message msg = Message(
                  title: addedSubject,
                  user: widget.user,
                  content: addedContent,
                  publishDate: DateTime.now());
              widget.messages.add(msg);
              setState(() {});
              Navigator.of(context).pop(msg);
              const snack =
                  SnackBar(content: Text('Message ajouté dans la liste'));
              ScaffoldMessenger.of(context).showSnackBar(snack);
            },
            child: const Text('OK'))
      ],
    );
  }
}
