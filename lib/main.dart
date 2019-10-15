import 'package:flutter/material.dart';

import 'ui/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color.fromRGBO(155, 81, 224, 1.0),
      ),
      home: LoginScreen(),
    );
  }
}
