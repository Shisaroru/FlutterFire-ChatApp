import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/chat/chat_argument.dart';
import 'package:myproject_app/services/database.dart';
import './group_info.dart';

class Chat extends StatefulWidget {
  final ChatArguments args;
  const Chat({super.key, required this.args});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot>? chats;
  List members = ["default"];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    chats = DatabaseService().getChats(widget.args.groupId);
    members = await DatabaseService().getGroupAdmin(widget.args.groupId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final data = ModalRoute.of(context)!.settings.arguments as ChatArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(data.groupName),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupInfo(
                      members: members,
                    ),
                  ));
            },
          )
        ],
      ),
      body: StreamBuilder(
        stream: chats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Text(members[0]);
        },
      ),
    );
  }
}
