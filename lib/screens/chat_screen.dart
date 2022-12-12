import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../control/cntrol.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final _messageTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  late User signedInUser;
  late int userId;
  String? messageText;
  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    getCurrentUser();
    // messagesStream();
    _messageTextController.clear();
    // Start listening to changes.
    _messageTextController.addListener;
    // setUserByEmail(_fireStore, signedInUser);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _messageTextController.dispose();
    super.dispose();
  }

  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      signedInUser = (user)!;
      print('line44 ${signedInUser.email}');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Hero(
              tag: 'Hero',
              child: Image.asset(
                'images/logo.png',
                height: 25,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Text('MessageMe')
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MessageStreamBuilder(
              fireStore: _fireStore,
              signedInUser: signedInUser,
              listViewController: _scrollController,
            ),
            Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.purple,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          hintText: 'Write your message here...',
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        Random random = new Random();
                        int encryptionId = random.nextInt(20) + 1;

                        _fireStore.collection('messages').add({
                          'text': encrypt(
                              _messageTextController.text, encryptionId),
                          'encryptionId': encryptionId,
                          'sender': signedInUser.email,
                          'time': FieldValue.serverTimestamp(),
                        });
                        setState(() {
                          _messageTextController.clear();
                          _scrollController.jumpTo(
                            _scrollController.position.maxScrollExtent,
                          );
                        });
                      },
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.purple,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder(
      {Key? key,
      required this.fireStore,
      required this.signedInUser,
      required this.listViewController})
      : super(key: key);
  final FirebaseFirestore fireStore;
  final User signedInUser;
  final ScrollController listViewController;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fireStore.collection('messages').orderBy('time').snapshots(),
        builder: (contex, snapshot) {
          List<MessageLine> messageWidgets = [];
          messageWidgets.clear();
          if (!snapshot.hasData) {
            return const Center(
              child: SizedBox(
                height: 25,
                width: 25,
                child: LoadingIndicator(
                  indicatorType: Indicator.circleStrokeSpin,
                  colors: [Colors.white],
                ),
              ),
            );
          }
          final messagesData = snapshot.data!.docs;

          for (var message in messagesData) {
            final messageText = message.get('text');
            final messageSender = message.get('sender');
            final encryptionId = message.get('encryptionId');

            final messageWidget = MessageLine(
              messageText: deCrypt(messageText.toString(), encryptionId),
              messageSender: messageSender,
              isMe: signedInUser.email == messageSender,
            );

            messageWidgets.add(messageWidget);
          }

          return Expanded(
            child: ListView(
              controller: listViewController,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageWidgets,
            ),
          );
        });
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({
    Key? key,
    required this.messageText,
    required this.messageSender,
    required this.isMe,
  }) : super(key: key);
  final String messageText;
  final String messageSender;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            messageSender,
            style: const TextStyle(color: Colors.black45),
          ),
          Material(
            elevation: 4,
            borderRadius: isMe
                ? const BorderRadius.only(
                    topRight: Radius.circular(0),
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))
                : const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
            color: isMe ? Colors.purple : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
              child: Text(
                messageText,
                style: TextStyle(
                    fontSize: 15,
                    color: isMe ? Colors.white : Colors.purple.shade800),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
