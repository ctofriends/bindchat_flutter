import 'package:flutter/material.dart';
import 'package:bindchat/screens/tag_screen.dart';
import 'package:bindchat/network/socket_service.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
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
                      socketService.connect("alanz");
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
