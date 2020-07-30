import 'package:cdparty_flutter/store/chat_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cdparty_flutter/screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [Provider<ChatStore>(create: (_) => ChatStore())],
        child: MaterialApp(
          title: 'CdParty',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.red,
            accentColor: Colors.orange,
          ),
          home: HomeScreen(),
        ));
  }
}
