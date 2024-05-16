import 'package:formulaire_exemple/api/message.dart';

class UserModel {
  final String nom;
  final String prenom;
  final List<Message>? messages;

  const UserModel({required this.nom, required this.prenom, required this.messages});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(nom: json['lastName'], prenom: json['firstName'], messages: json['Messages']);
  }
}