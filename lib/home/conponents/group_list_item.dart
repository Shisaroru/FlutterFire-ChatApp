import 'package:flutter/material.dart';
import 'package:myproject_app/chat/chat_argument.dart';

class GroupItem extends StatelessWidget {
  final String groupName;
  final String groupId;
  const GroupItem({super.key, required this.groupName, required this.groupId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.pushNamed(context, '/chat',
            arguments: ChatArguments(groupName, groupId));
      },
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: Colors.black26,
        leading: CircleAvatar(
          radius: 25,
          child: Text(
            groupName[0].toUpperCase(),
            style: const TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        title: Text(groupName),
        subtitle: Text(groupId),
      ),
    );
  }
}
