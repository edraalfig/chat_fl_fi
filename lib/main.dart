import 'package:chat_fl_fi/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat',
      home: const LoginPage(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.green),
      ),
    );
  }
}

/* class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Fl&Fi',
      initialRoute: 'chat',
      routes: {
        'login': (_) => const LoginPage(),
        'registro': (_) => const RegisterPage(),
      },
    );
  }
} */
