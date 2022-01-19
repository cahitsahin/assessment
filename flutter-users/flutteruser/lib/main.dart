import 'package:flutter/material.dart';
import 'package:flutteruser/blocs/user_provider.dart';
import 'package:flutteruser/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home:UserProvider(child: const HomePage(),),
    );
  }
}
