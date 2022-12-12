import 'package:flutter/material.dart';

import '../widgets/my_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: Column(
                  children: [
                    Hero(
                      tag: 'Hero',
                      child: Image.asset(
                        'images/logo.png',
                        height: 150,
                      ),
                    ),
                    const Text(
                      'SyperMessage',
                      style: TextStyle(
                        fontSize: 40,
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF480F65),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                color: Colors.purple,
                title: 'Sing in',
                function: () {
                  Navigator.pushNamed(context, 'SignInScreen');
                },
                isWaiting: false,
              ),
              MyButton(
                color: Colors.purple.shade700,
                title: 'Register',
                function: () {
                  Navigator.pushNamed(context, 'RegisterScreen');
                },
                isWaiting: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
