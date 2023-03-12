import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message, String type) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: TextStyle(color: (type == "error" ? Colors.red : Colors.black)),
    ),
  ));
}
