import 'package:formulaire_exemple/message/model/message.dart';

class User {
  final String nom;
  final String prenom;
  final List<Message>? messages;

  List<Message> get messagesList => messages!;

  const User({required this.nom, required this.prenom, this.messages});

  @override
  String toString() {
    return 'User: $nom $prenom';
  }
}