import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/app_state.dart';
import 'package:myproject_app/chat/chat_argument.dart';
import 'package:myproject_app/chat/components/message_tile.dart';
import 'package:myproject_app/services/auth.dart';
import 'package:myproject_app/services/database.dart';
import 'package:provider/provider.dart';
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
    members = await DatabaseService().getGroupMembers(widget.args.groupId);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final messageController = TextEditingController();
    final data = ModalRoute.of(context)!.settings.arguments as ChatArguments;
    return Scaffold(
        appBar: AppBar(
          title: Text(data.groupName),
          centerTitle: true,
          actions: [
            PopupMenuButton(
              position: PopupMenuPosition.under,
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: TextButton(
                    child: const Text(
                      "Group Info",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupInfo(
                            members: members,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                PopupMenuItem(
                  child: TextButton(
                    child: const Text(
                      "Leave Group",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {
                      DatabaseService(uid: Auth().firebaseAuth.currentUser!.uid)
                          .toggleJoinGroup(data.groupId, data.groupName);
                      // close the drop down
                      Navigator.pop(context);
                      // back to home
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  child: StreamBuilder(
                    stream: chats,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return MessageTile(
                              message: snapshot.data!.docs[index]['message'],
                              sender: snapshot.data!.docs[index]['sender'],
                              sentByMe: context.read<AppState>().name ==
                                  snapshot.data!.docs[index]["sender"],
                            );
                          },
                        );
                      }
                      return const Text(
                          "Send a message to start the conversation");
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "Enter a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (messageController.text.isNotEmpty) {
                        Map<String, dynamic> chatMessage = {
                          "message": messageController.text,
                          "sender": context.read<AppState>().name,
                          "time": DateTime.now().millisecondsSinceEpoch,
                        };
                        DatabaseService()
                            .sendMessage(data.groupId, chatMessage);
                        messageController.clear();
                      }
                    },
                    icon: const Icon(Icons.send),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
