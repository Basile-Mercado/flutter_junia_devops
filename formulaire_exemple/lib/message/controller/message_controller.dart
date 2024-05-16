import 'package:formulaire_exemple/message/model/message.dart';
import 'package:formulaire_exemple/user/model/user.dart';

class MessageController {
  final List<Message> _messages = [];

  List<Message> get messages => _messages;

  Future loadMessages(List<User> users) async {
    messages.add(Message(title: 'Sujet 1', content: 'Contenu 1', user: users[0], publishDate: DateTime(2024, 4, 12)));
    messages.add(Message(title: 'Sujet 2', content: 'Contenu 2', user: users[1], publishDate: DateTime(2024, 4, 12)));
    messages.add(Message(title: 'Sujet 3', content: 'Contenu 3', user: users[2], publishDate: DateTime(2024, 4, 12)));
  }
}