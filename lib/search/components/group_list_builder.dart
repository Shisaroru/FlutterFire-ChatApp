import 'package:flutter/material.dart';
import 'package:myproject_app/services/auth.dart';
import 'package:myproject_app/services/database.dart';

class GroupList extends StatefulWidget {
  final String groupName;
  final String groupId;
  final Future<bool> joined;

  const GroupList({
    super.key,
    required this.groupName,
    required this.groupId,
    required this.joined,
  });

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  bool join = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    join = await widget.joined;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      tileColor: Colors.black26,
      leading: CircleAvatar(
        radius: 25,
        child: Text(
          (widget.groupName[0]).toUpperCase(),
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      title: Text(
        widget.groupName,
      ),
      subtitle: Text("ID: ${widget.groupId}"),
      trailing: ElevatedButton(
        onPressed: () {
          DatabaseService(uid: Auth().firebaseAuth.currentUser!.uid)
              .toggleJoinGroup(widget.groupId, widget.groupName);
          setState(() {
            join = !join;
          });
        },
        child: join ? const Text("Joined") : const Text("Join"),
      ),
    );
  }
}
