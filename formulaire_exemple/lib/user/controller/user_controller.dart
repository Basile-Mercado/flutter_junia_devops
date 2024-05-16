import 'package:formulaire_exemple/user/model/user.dart';

class UserController {
  final List<User> _users = [];

  List<User> get users => _users;

  Future loadUsers() async{
    users.add(const User(nom: 'Dupont', prenom: 'Bertrand'));
    users.add(const User(nom: 'Leroy', prenom: 'Jean'));
    users.add(const User(nom: 'Dupont', prenom: 'Jacques'));
  }
}