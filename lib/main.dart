import 'package:bindchat/store/chat_store.dart';
import 'package:bindchat/store/home_store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bindchat/screens/home_screen.dart';
import 'package:bindchat/network/socket_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final service = SocketService();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<ChatStore>(create: (_) => ChatStore(service)),
          Provider<HomeStore>(create: (_) => HomeStore(service)),
        ],
        child: MaterialApp(
          title: 'BindChat',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.red,
            accentColor: Colors.orange,
          ),
          home: HomeScreen(),
        ));
  }
}
