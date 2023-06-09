import 'package:flutter/material.dart';
import 'package:myproject_app/auth/login.dart';
import 'package:myproject_app/auth/register.dart';
import 'package:myproject_app/chat/chat_argument.dart';
import 'package:myproject_app/chat/chat_screen.dart';
import 'package:myproject_app/contact/contact.dart';
import 'package:myproject_app/home/home.dart';
import 'package:myproject_app/profile/profile.dart';
import 'package:myproject_app/search/search.dart';

var appRoutes = {
  '/': (context) => const Login(),
  '/home': (context) => const Home(),
  '/register': (context) => const Register(),
  '/contact': (context) => const Contact(),
  '/profile': (context) => const Profile(),
  '/search': (context) => const Search(),
  '/chat': (context) => Chat(
        args: ModalRoute.of(context)!.settings.arguments as ChatArguments,
      ),
};
