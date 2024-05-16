import 'package:flutter/material.dart';
import 'package:formulaire_exemple/api/user.dart';
import 'package:formulaire_exemple/model/model_user.dart';

class FutureUsers extends StatefulWidget {
  const FutureUsers({super.key});

  @override
  State<FutureUsers> createState() => FutureUsersState();
}

class FutureUsersState extends State<FutureUsers> {
  late Future<List<UserModel>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: futureUsers,
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
            child: Text('Aucun Utilisateur n\'a été trouvé'),
          );
        } else {
          List<UserModel> users = snapshot.data!;
          return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(users[index].prenom),
                  subtitle: Text(users[index].nom),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: users.length);
        }
      },
    );
  }
}
