import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject_app/search/components/group_list_builder.dart';
import 'package:myproject_app/services/auth.dart';
import 'package:myproject_app/services/database.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  QuerySnapshot? searchSnapshot;
  final ctr = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search"),
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextField(
              controller: ctr,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (ctr.text.isNotEmpty) {
                      searchSnapshot =
                          await DatabaseService().searchGroupByName(ctr.text);
                      setState(() {});
                    }
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 30,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            (searchSnapshot != null && searchSnapshot!.docs.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                        itemCount: searchSnapshot!.docs.length,
                        itemBuilder: (context, index) {
                          return GroupList(
                            groupName: searchSnapshot!.docs[index]["groupName"],
                            groupId: searchSnapshot!.docs[index]['groupId'],
                            joined: DatabaseService(
                                    uid: Auth().firebaseAuth.currentUser!.uid)
                                .isJoinedGroup(
                              searchSnapshot!.docs[index]['groupId'],
                              searchSnapshot!.docs[index]["groupName"],
                            ),
                          );
                        }),
                  )
                : const Center(
                    child: Text(
                      "No group found",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 27,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
