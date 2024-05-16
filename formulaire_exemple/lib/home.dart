import 'package:flutter/material.dart';
import 'package:formulaire_exemple/api/message.dart';
import 'package:formulaire_exemple/global_widget/future_messages.dart';
import 'package:formulaire_exemple/global_widget/future_users.dart';
import 'package:formulaire_exemple/global_widget/scaffold.dart';
import 'package:formulaire_exemple/model/model_message.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late Future<List<MessageModel>> futureMessages;

  @override
  void initState() {
    super.initState();
    futureMessages = Message().fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: GlobalScaffold(
        shouldDisplayTopBar: true,
        name: 'Home',
        body: TabBarView(
          children: [
            FutureMessages(),
            FutureUsers(),
          ],
        ),
      ),
    );
  }
}
