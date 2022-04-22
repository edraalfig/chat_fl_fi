import 'package:chat_fl_fi/pages/login.dart';
import 'package:chat_fl_fi/widgets/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String email;
  const ChatPage({Key? key, required this.email}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final fs = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  final message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chats',
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut().whenComplete(() => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  ));
            },
            icon: const Icon(
              Icons.logout,
              size: 30,
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.85,
              child: Messages(email: widget.email),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextFormField(
                  controller: message,
                  style: const TextStyle(fontSize: 25),
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Mensaje',
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 2.5),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.5),
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                  onSaved: (value) {
                    message.text = value!;
                  },
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: IconButton(
                  onPressed: () {
                    if (message.text.isNotEmpty) {
                      fs.collection('Messages').doc().set({
                        'message': message.text.trim(),
                        'time': DateTime.now(),
                        'email': widget.email,
                      });
                      message.clear();
                    }
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
          const SizedBox()
        ],
      ),
    );
  }
}
