import 'package:flutter/material.dart';

class ChatMessage {
  final String message;

  ChatMessage(this.message);
}

class ChatScreen extends StatelessWidget {
  final List<ChatMessage> messages = [
    ChatMessage("hello"),
    ChatMessage("hello"),
    ChatMessage("hello"),
    ChatMessage("hello"),
    ChatMessage("hello"),
    ChatMessage("hello")
  ];
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
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Text(messages[index].message);
                    },
                  )),
                  TextField(
                      decoration: InputDecoration(hintText: 'Send message')),
                ]))));
  }
}
