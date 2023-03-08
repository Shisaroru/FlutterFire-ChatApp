import 'package:myproject_app/shared/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact"),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
