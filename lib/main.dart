import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bindchat/screens/home_screen.dart';

import 'model/backend.dart';

void main() =>
    runApp(Provider<Backend>.value(value: new Backend(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BindChat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.orange,
      ),
      home: HomeScreen(),
    );
  }
}
