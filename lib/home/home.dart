import 'package:flutter/material.dart';
import 'package:myproject_app/shared/drawer.dart';
import 'package:myproject_app/shared/drawer_builder.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        leading: const DrawerBuilder(),
      ),
      drawer: const AppDrawer(),
    );
  }
}
