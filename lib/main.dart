import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/signIn_screen.dart';
import 'package:chat_app/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Syper Chat',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: _auth.currentUser != null ? 'ChatScreen' : '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        'SignInScreen': (context) => const SignInScreen(),
        'RegisterScreen': (context) => const RegisterScreen(),
        'ChatScreen': (context) => const ChatScreen(),
      },
    );
  }
}
