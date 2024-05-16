import 'package:flutter/material.dart';
import 'package:formulaire_exemple/api/login_screen.dart';
import 'package:formulaire_exemple/api/profile.dart';
import 'package:formulaire_exemple/api/register_screen.dart';
import 'package:formulaire_exemple/home.dart';
import 'package:formulaire_exemple/providers/auth_provider.dart';
import 'package:formulaire_exemple/user/view/list.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.indigo,
        )
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/list': (context) => const ListExemple(),
        '/register': (context) => const RegisterScreen(),
        '/login': (context) => const LoginScreen(),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}
