import 'package:bindchat/store/home_store.dart';
import 'package:flutter/material.dart';
import 'package:bindchat/screens/tag_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final store = Provider.of<HomeStore>(context);
    store.onNewRoom = handleNewRoom;

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
                  onChanged: store.handleChanged,
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
                    onPressed: store.connect,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  handleNewRoom(String room) {
    print(room);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => TagScreen()));
  }
}
