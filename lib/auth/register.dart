import 'package:flutter/material.dart';
import 'package:myproject_app/auth/conponents/auth_button.dart';
import 'package:myproject_app/auth/conponents/input.dart';
import 'package:myproject_app/shared/show_snack_bar.dart';

import '../services/auth.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
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
                      label: "Full Name",
                      icon: const Icon(
                        Icons.person,
                      ),
                      showInput: true,
                      validator: "name",
                      controller: nameController,
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

  register() async {
    if (formKey.currentState!.validate()) {
      FocusManager.instance.primaryFocus?.unfocus();
      setState(() {
        _isLoading = true;
      });

      var success = await Auth().register(
        nameController.text,
        emailController.text,
        passwordController.text,
      );

      if (success == "") {
        // await Preference.setLoggedInEmail(emailController.text);
        // await Preference.setLogType("normal");
        // await Preference.setLoggedInStatus(true);
        setState(() {
          _isLoading = false;
        });
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/');
        }
      }

      setState(() {
        _isLoading = false;
      });

      if (success != "" && mounted) {
        showSnackBar(context, success, "error");
      }
    }
  }
}
