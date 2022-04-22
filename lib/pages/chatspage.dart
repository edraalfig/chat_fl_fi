// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  List docUsers = [];
  final Stream<QuerySnapshot> _userStream =
      FirebaseFirestore.instance.collection('user').snapshots();

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  void getUsers() async {
    QuerySnapshot users =
        await FirebaseFirestore.instance.collection('user').get();
    if (users.docs.isNotEmpty) {
      setState(() {
        docUsers = users.docs;
      });
      print(docUsers.elementAt(1).data());
    } else {
      print('no hay datos');
    }
  }

  Widget _buildListItem(
      BuildContext context, QueryDocumentSnapshot documentSnapshot) {
    return ListTile(
      title: Row(
        children: [
          Text(
            documentSnapshot['email'],
            style: Theme.of(context).textTheme.headline4,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'ChatsPage',
        style: TextStyle(fontSize: 30),
      )),
      body: SafeArea(
        child: StreamBuilder(
          stream: _userStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text(
                'HA OCURRIDO UN ERROR',
                style: TextStyle(fontSize: 30),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.green,
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              primary: true,
              itemBuilder: (context, index) =>
                  _buildListItem(context, snapshot.data!.docs[index]),
            );
          },
        ),
      ),
    );
  }
}
