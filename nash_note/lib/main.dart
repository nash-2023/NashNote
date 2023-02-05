import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:nash_note/1_view/auth/login.dart';
import 'package:nash_note/1_view/auth/sign_up.dart';
import 'package:nash_note/1_view/crud/addnote.dart';
import 'package:nash_note/1_view/home/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = FirebaseAuth.instance.currentUser;
    return MaterialApp(
      title: 'Note Book',
      debugShowCheckedModeBanner: false,
      initialRoute: (user == null) ? 'login' : 'homepage',
      // home: Login(),
      routes: {
        'login': (context) => Login(),
        'signup': (context) => Signup(),
        'homepage': (context) => HomePage(),
        'addnote': (context) => Addnote(),
      },
      theme: ThemeData(
        primaryColor: Colors.red,
        textTheme: TextTheme(),
      ),
    );
  }
}
