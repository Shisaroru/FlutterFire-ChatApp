import 'package:flutter/material.dart';
import 'package:myproject_app/auth/conponents/input.dart';
import 'package:myproject_app/auth/conponents/auth_button.dart';
import 'package:myproject_app/home/home.dart';
import 'package:myproject_app/services/auth.dart';
import '../services/share_preference.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  login() {
    if (formKey.currentState!.validate()) {}
  }

  register() {
    Navigator.pushReplacementNamed(context, '/register');
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return const Text("error");
        } else if (snapshot.hasData) {
          return const Home();
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: Container(
            padding: const EdgeInsets.all(30),
            alignment: Alignment.center,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "CHAT APP",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Input(
                    label: "Email",
                    icon: const Icon(
                      Icons.email,
                    ),
                    showInput: true,
                    validator: "email",
                    controller: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Input(
                    label: "Password",
                    icon: const Icon(
                      Icons.lock,
                    ),
                    showInput: false,
                    validator: "password",
                    controller: passwordController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    color: Colors.blue,
                    text: "Log in",
                    method: login,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    color: Colors.white,
                    text: "Log in with Google",
                    method: Auth().googleSignIn,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  AuthButton(
                    color: Colors.green,
                    text: "Create a new account",
                    method: register,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
