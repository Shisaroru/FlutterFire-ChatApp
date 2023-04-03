import 'package:flutter/material.dart';
import 'package:myproject_app/services/auth.dart';
import 'package:provider/provider.dart';

import '../app_state.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          const Icon(
            Icons.account_circle,
            size: 120,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            context.read<AppState>().name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          ListTile(
            title: const Text("Chat"),
            leading: const Icon(
              Icons.email,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
          ListTile(
            title: const Text("Contacts"),
            leading: const Icon(
              Icons.group,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/contact');
            },
          ),
          ListTile(
            title: const Text("Setting"),
            leading: const Icon(
              Icons.settings,
            ),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            title: const Text('Log out'),
            leading: const Icon(
              Icons.logout,
            ),
            onTap: () {
              Auth().signOut();
            },
          )
        ],
      ),
    );
  }
}
