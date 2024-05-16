import 'package:flutter/material.dart';
import 'package:formulaire_exemple/message/controller/message_controller.dart';
import 'package:formulaire_exemple/message/model/message.dart';
import 'package:formulaire_exemple/user/model/user.dart';

class MessageEditDialog extends StatefulWidget {
  final List<Message> messages;
  final Message originalMsg;
  final User user;

  const MessageEditDialog(
      {super.key,
      required this.originalMsg,
      required this.user,
      required this.messages});

  @override
  State<StatefulWidget> createState() => MessageEditDialogState();
}

class MessageEditDialogState extends State<MessageEditDialog> {
  final MessageController controller = MessageController();
  late TextEditingController subject;
  late TextEditingController content;
  String addedSubject = '';
  String addedContent = '';

  @override
  void initState() {
    super.initState();
    subject = TextEditingController();
    subject.text = widget.originalMsg.title;
    content = TextEditingController();
    content.text = widget.originalMsg.content;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifier un message'),
      content: Column(
        children: [
          TextField(
            controller: subject,
            onChanged: (value) {
              setState(() {
                addedSubject = value;
              });
            },
          ),
          TextField(
            controller: content,
            onChanged: (value) {
              setState(() {
                addedContent = value;
              });
            },
          )
        ],
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              if (addedContent == '' && addedSubject == '') {
                const snack = SnackBar(
                    content: Text('Vous n\'avez pas remplis les champs'));
                ScaffoldMessenger.of(context).showSnackBar(snack);
                return;
              }
              final int index = widget.messages.indexOf(widget.originalMsg);
              widget.messages.remove(widget.originalMsg);
              setState(() {});
              final Message newMsg = Message(
                title: addedSubject,
                user: widget.user,
                content: addedContent,
                publishDate: DateTime.now(),
              );
              setState(() {});
              widget.messages.insert(index, newMsg);
              setState(() {});
              Navigator.of(context).pop(newMsg);
              const snack =
                  SnackBar(content: Text('Message modifié dans la liste'));
              ScaffoldMessenger.of(context).showSnackBar(snack);
            },
            child: const Text('OK'))
      ],
    );
  }
}
