import 'package:flutter/material.dart';


import 'package:teste/login.dart';

//https://dog.ceo/api/breeds/image/random
//https://aws.random.cat/meow
//https://api.nationalize.io/?name=anderson

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}