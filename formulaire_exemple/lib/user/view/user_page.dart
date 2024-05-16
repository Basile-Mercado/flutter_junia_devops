import 'package:flutter/material.dart';
import 'package:formulaire_exemple/message/message_dialog.dart';
import 'package:formulaire_exemple/message/message_edit_dialog.dart';
import 'package:formulaire_exemple/message/model/message.dart';
import 'package:formulaire_exemple/user/model/user.dart';

class UserPage extends StatefulWidget {
  final User user;
  final List<Message> messages;

  const UserPage({super.key, required this.user, required this.messages});

  @override
  State<StatefulWidget> createState() => UserPageState();
}

class UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page de ${widget.user.nom} ${widget.user.prenom}'),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: widget.messages.length,
              (context, index) => ListTile(
                onTap: () async {
                  final newMsg = await showDialog(
                    context: context,
                    builder: (context) => MessageEditDialog(
                      originalMsg: widget.messages[index],
                      user: widget.user,
                      messages: widget.messages,
                    ),
                  );
                  if (widget.messages.contains(newMsg)) {
                    setState(() {});
                  }
                },
                title: Text(
                  widget.messages[index].title,
                  style: const TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  widget.messages[index].content,
                  style: const TextStyle(fontSize: 18),
                ),
                trailing: Text(
                  widget.messages[index].publishDate.toString(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final message = await showDialog(
            context: context,
            builder: (context) =>
                MessageDialog(messages: widget.messages, user: widget.user),
          );
          if (widget.messages.contains(message)) {
            setState(() {});
          }
        },
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}
