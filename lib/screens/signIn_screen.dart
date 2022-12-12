import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _auth = FirebaseAuth.instance;
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isWaiting = false;
  @override
  void initState() {
    super.initState();
    _emailController.clear();
    _passwordController.clear();
    // Start listening to changes.
    _emailController.addListener;
    _passwordController.addListener;
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _emailController.dispose();
    _passwordController.dispose();
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: 'Hero',
              child: Image.asset(
                'images/logo.png',
                height: 150,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            MyTextField(
              title: 'Enter your email',
              myController: _emailController,
            ),
            const SizedBox(
              height: 15,
            ),
            MyTextField(
              title: 'Enter your password',
              myController: _passwordController,
            ),
            const SizedBox(
              height: 20,
            ),
            MyButton(
              color: Colors.purple,
              title: 'Sign in',
              function: () async {
                try {
                  setState(() {
                    _isWaiting = true;
                  });
                  final user = await _auth.signInWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);
                  if (user != null) {
                    setState(() {
                      _isWaiting = false;
                    });

                    Navigator.pushNamed(context, 'ChatScreen');
                  }
                } catch (e) {
                  setState(() {
                    _isWaiting = false;
                  });

                  print(e);
                }
              },
              isWaiting: _isWaiting,
            )
          ],
        ),
      ),
    );
  }
}
