import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/presentation/login/login_page.dart';
import 'package:todo/presentation/main/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // これをつけないとなぜか怒られる。
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirebaseAuth.instance.currentUser == null ? const LoginPage() : const MainPage(),
    );
  }
}
