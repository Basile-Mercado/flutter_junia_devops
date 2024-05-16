import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class GlobalScaffold extends StatelessWidget {
  final Widget body;
  final String name;
  final List<Widget> actions;
  final bool shouldDisplayTopBar;

  const GlobalScaffold({
    Key? key,
    required this.body,
    required this.name,
    this.actions = const [],
    required this.shouldDisplayTopBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(name, style: const TextStyle(color: Colors.white)),
        elevation: 10.0,
        centerTitle: true,
        bottom: shouldDisplayTopBar ? const TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white,
          tabs: [
            Tab(
              icon: Icon(Icons.message, color: Colors.white),
              text: 'Liste des messages',
            ),
            Tab(
              icon: Icon(Icons.people, color: Colors.white,),
              text: 'Liste des utilisateurs',
            ),
          ],
        ) : null,
        actions: [
          IconButton(
            icon: Icon(authProvider.isLoggedIn ? Icons.person : Icons.app_registration, color: Colors.white),
            onPressed: () {
              if (authProvider.isLoggedIn) {
                authProvider.logout();
                Navigator.pushNamed(
                  context,
                  '/profile',
                );
              } else {
                Navigator.pushNamed(
                  context,
                  '/register',
                );
              }
            },
          ),
          IconButton(
            onPressed: () {
              if (authProvider.isLoggedIn) {
                authProvider.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/login',
                  (Route<dynamic> route) => false,
                );
              } else {
                Navigator.pushNamed(
                  context,
                  '/login',
                );
              }
            },
            icon: Icon(
              authProvider.isLoggedIn ? Icons.logout : Icons.login,
              color: Colors.white,
            ),
          )
        ],
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: body,
    );
  }
}
