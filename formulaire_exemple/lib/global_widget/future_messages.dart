import 'package:flutter/material.dart';
import 'package:formulaire_exemple/api/message.dart';
import 'package:formulaire_exemple/model/model_message.dart';

class FutureMessages extends StatefulWidget {
  const FutureMessages({super.key});

  @override
  State<FutureMessages> createState() => FutureMessagesState();
}

class FutureMessagesState extends State<FutureMessages>{
  late Future<List<MessageModel>> futureMessages;

  @override
  void initState() {
    super.initState();
    futureMessages = Message().fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureMessages,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Erreur: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('Aucun Message n\'a été trouvé'),
          );
        } else {
          List<MessageModel> messages = snapshot.data!;
          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(messages[index].subject),
                subtitle: Text(messages[index].body),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: messages.length,
          );
        }
      },
    );
  }
}