import 'package:flutter/material.dart';
import 'package:myproject_app/app_state.dart';
import 'package:myproject_app/home/conponents/group_list_item.dart';
import 'package:myproject_app/services/auth.dart';
import 'package:myproject_app/services/database.dart';
import 'package:myproject_app/shared/drawer.dart';
import 'package:myproject_app/shared/drawer_builder.dart';
import 'package:myproject_app/shared/show_snack_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();
  final groupController = TextEditingController();

  String getGroupId(String str) {
    return str.substring(0, str.indexOf("_"));
  }

  String getGroupName(String str) {
    return str.substring(str.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/search");
            },
            icon: const Icon(
              Icons.search,
              size: 32,
            ),
          )
        ],
        title: const Text(
          "Chat",
          style: TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const DrawerBuilder(),
      ),
      drawer: const AppDrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text("Create a new group"),
                content: Form(
                  key: formKey,
                  child: TextFormField(
                    controller: groupController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Name of the group is required";
                      }
                      return null;
                    },
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        DatabaseService(
                                uid: Auth().firebaseAuth.currentUser!.uid)
                            .createGroup(Auth().firebaseAuth.currentUser!.uid,
                                groupController.text);

                        Navigator.of(context).pop();
                        showSnackBar(context, "Created group", "");
                      }
                    },
                    child: const Text("Create"),
                  ),
                ],
              );
            },
          );
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: context.watch<AppState>().userGroupsStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data["groups"].length == 0) {
              return const Center(
                child: Text(
                  "NO BITCHES?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data["groups"].length,
              itemBuilder: (context, index) {
                int reverseIndex = snapshot.data["groups"].length - index - 1;
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 5,
                  ),
                  child: GroupItem(
                    groupName:
                        getGroupName(snapshot.data["groups"][reverseIndex]),
                    groupId: getGroupId(snapshot.data["groups"][reverseIndex]),
                  ),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
