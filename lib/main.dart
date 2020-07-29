import 'package:flutter/material.dart';
import 'package:cdparty_flutter/screens/chat_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CdParty',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Colors.orange,
      ),
      home: ChatScreen(),
    );
  }
}
