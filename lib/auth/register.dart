import 'package:flutter/material.dart';
import 'package:myproject_app/auth/conponents/auth_button.dart';
import 'package:myproject_app/auth/conponents/input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              const Input(
                label: "Email",
                icon: Icon(
                  Icons.email,
                ),
                showInput: true,
                validator: "email",
              ),
              const SizedBox(
                height: 15,
              ),
              const Input(
                label: "Full Name",
                icon: Icon(
                  Icons.person,
                ),
                showInput: true,
                validator: "name",
              ),
              const SizedBox(
                height: 15,
              ),
              const Input(
                label: "Password",
                icon: Icon(
                  Icons.lock,
                ),
                showInput: false,
                validator: "password",
              ),
              const SizedBox(
                height: 15,
              ),
              AuthButton(
                color: Colors.green,
                text: "Create account",
                method: register,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthButton(
                color: Colors.blue,
                text: "Already have an account",
                method: login,
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() {
    Navigator.pushReplacementNamed(context, '/');
  }

  register() {
    print(formKey.currentState!.validate());
  }
}
