import 'package:flutter/material.dart';
import 'package:myproject_app/services/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const DrawerHeader(
            child: Text("Header"),
          ),
          ListTile(
            title: const Text("Chat"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text("Contacts"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/contact');
            },
          ),
          ListTile(
            title: const Text("Setting"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          ListTile(
            title: const Text('Log out'),
            onTap: () {
              Auth().signOut();
            },
          )
        ],
      ),
    );
  }
}
