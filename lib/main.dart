import 'package:flutter/material.dart';
import 'package:myproject_app/app_state.dart';
import 'package:myproject_app/auth/login.dart';
import 'package:myproject_app/routes.dart';
import 'package:myproject_app/theme.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppState()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: appRoutes,
        initialRoute: '/',
        theme: appTheme,
      ),
    );
  }
}
