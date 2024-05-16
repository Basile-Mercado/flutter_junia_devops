import 'package:flutter/material.dart';
import 'package:formulaire_exemple/global_widget/scaffold.dart';
import 'package:formulaire_exemple/utils/secure_storage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  Future<Map<String, String?>> getInfos() async {
    SecureStorage storage = SecureStorage();
    final Map<String, String?> userInfos = await storage.readCredentials();
    return userInfos;
  }

  @override
  Widget build(BuildContext context) {
    return GlobalScaffold(
      shouldDisplayTopBar: false,
        body: FutureBuilder(
          future: getInfos(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final String? firstName = snapshot.data!['firstName'];
              final String? lastName = snapshot.data!['lastName'];
              return Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Text(
                        'Vous pouvez retrouvrez ici vos informations',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child:
                          Text('Votre prénom:', style: TextStyle(fontSize: 20)),
                    ),
                    Text('$firstName', style: const TextStyle(fontSize: 20)),
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 16.0),
                      child: Text('Votre nom:', style: TextStyle(fontSize: 20)),
                    ),
                    Text('$lastName', style: const TextStyle(fontSize: 20)),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Vous n\'êtes pas connecté'),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pushNamed('/'),
                        child: const Text('Revenir à l\'accueil'))
                  ],
                ),
              );
            }
          },
        ),
        name: 'Mon profil');
  }
}
