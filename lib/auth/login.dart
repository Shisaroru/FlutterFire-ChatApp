import 'package:flutter/material.dart';
import 'package:myproject_app/home/home.dart';
import 'package:myproject_app/services/auth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        } else if (snapshot.hasError) {
          return const Text("error");
        } else if (snapshot.hasData) {
          return const Home();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
        );
      },
    );
  }
}
