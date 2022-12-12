import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/my_button.dart';
import '../widgets/my_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isWaiting = false;
  final _auth = FirebaseAuth.instance;
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

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
              color: Colors.purple.shade700,
              title: 'Register',
              function: () async {
                try {
                  setState(() {
                    _isWaiting = true;
                  });
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: _emailController.text,
                      password: _passwordController.text);
                  // Random random = new Random();
                  // int newId = random.nextInt(20) + 1;
                  // await for (var snapshot
                  //     in _fireStore.collection('users').snapshots()) {
                  //   for (var user in snapshot.docs) {
                  //     print('line60 ${user.data()}');
                  //     newId++;
                  //   }
                  // }
                  // newId =
                  //     _fireStore.collection('users').snapshots().length as int;
                  // print('line 105 :  $newId');
                  // final int newId =
                  //     await _fireStore.collection('users').snapshots().length;

                  // addUserName(
                  //     fireStore: _fireStore,
                  //     userName: _nameController.text,
                  //     email: _emailController.text);
                  if (newUser != null) {
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
