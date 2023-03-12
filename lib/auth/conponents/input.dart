import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String label;
  final Icon icon;
  final bool showInput;
  final String validator;

  const Input({
    super.key,
    required this.label,
    required this.icon,
    required this.showInput,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (validator == "email") {
          return RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(value!)
              ? null
              : "Please enter a valid email address";
        } else if (validator == "password" && value!.length < 6) {
          return "Password must be at least 6 characters";
        } else if (value!.isEmpty) {
          return "This field is required";
        }
        return null;
      },
      obscureText: !showInput,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue,
            width: 2,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2,
          ),
        ),
      ),
    );
  }
}
