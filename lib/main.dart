import 'package:flutter/material.dart';
import 'package:hr_app/src/ui/login/register_screen.dart';
import 'package:hr_app/src/ui/main_screen/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const RegisterScreen(),
    );
  }
}
