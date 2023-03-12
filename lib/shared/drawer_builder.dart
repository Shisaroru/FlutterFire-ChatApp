import 'package:flutter/material.dart';

class DrawerBuilder extends StatelessWidget {
  const DrawerBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
          icon: const Icon(Icons.account_circle),
          iconSize: 40,
          onPressed: () {
            Scaffold.of(context).openDrawer();
          });
    });
  }
}
