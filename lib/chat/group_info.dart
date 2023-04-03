import 'package:flutter/material.dart';

class GroupInfo extends StatelessWidget {
  final List members;
  const GroupInfo({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Group Information"),
        centerTitle: true,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 15,
          );
        },
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        itemCount: members.length - 1,
        itemBuilder: (context, index) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            tileColor: Colors.black26,
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(members[index]),
            subtitle: members[index] == members[members.length - 1]
                ? const Text("Admin")
                : const Text(""),
          );
        },
      ),
    );
  }
}
