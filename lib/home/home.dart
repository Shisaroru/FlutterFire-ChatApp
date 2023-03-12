import 'package:flutter/material.dart';
import 'package:myproject_app/shared/drawer.dart';
import 'package:myproject_app/shared/drawer_builder.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
    );
  }
}
