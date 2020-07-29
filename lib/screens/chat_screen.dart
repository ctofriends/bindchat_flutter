import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(title: Text('Tibia')),
        body: SafeArea(
            child: Container(
                color: Colors.blue,
                child: Column(children: <Widget>[
                  Expanded(
                      child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (BuildContext context, int index) {
                      return Text("Hello");
                    },
                  )),
                  TextField(
                      decoration: InputDecoration(hintText: 'Send message')),
                ]))));
  }
}
