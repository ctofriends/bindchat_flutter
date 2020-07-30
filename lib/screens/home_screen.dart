import 'package:flutter/material.dart';
import 'package:cdparty_flutter/screens/tag_screen.dart';
import 'package:phoenix_wings/phoenix_wings.dart';

final socket = new PhoenixSocket("ws://10.0.2.2:4000/socket/websocket",
    socketOptions: PhoenixSocketOptions(params: {"token": "alan"}));

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: SafeArea(
        child: Center(
          child: Container(
            decoration: BoxDecoration(color: Colors.blue),
            constraints: BoxConstraints.tightForFinite(
                height: 200.0, width: double.infinity),
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'BindChat',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold),
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.red,
                      hintStyle: TextStyle(color: Colors.white),
                      hintText: '@handle'),
                ),
                Container(
                  decoration:
                      ShapeDecoration(color: Colors.red, shape: CircleBorder()),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.chat),
                    onPressed: () async {
                      await socket.connect();
                      final chatChannel = socket.channel("lobby");
                      chatChannel.join();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TagScreen()));
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
