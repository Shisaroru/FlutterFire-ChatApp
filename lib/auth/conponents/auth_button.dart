import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function method;

  const AuthButton({
    super.key,
    required this.color,
    required this.text,
    required this.method,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        method();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 18,
            color: (color == Colors.white) ? Colors.black : Colors.white),
      ),
    );
  }
}
