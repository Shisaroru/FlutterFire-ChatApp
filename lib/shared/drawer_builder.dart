import 'package:flutter/material.dart';

class DrawerBuilder extends StatelessWidget {
  const DrawerBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return IconButton(
          icon: const Icon(Icons.accessible),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          });
    });
  }
}
