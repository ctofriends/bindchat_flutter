import 'package:flutter/material.dart';

enum ChatMessageType { incoming, outgoing }

class ChatMessage {
  final String message;
  final ChatMessageType type;

  ChatMessage(this.message, this.type);
}

class ChatScreen extends StatelessWidget {
  final List<ChatMessage> messages = [
    ChatMessage("Hello", ChatMessageType.incoming),
    ChatMessage("Hi my friend", ChatMessageType.outgoing),
    ChatMessage("Do you liek tibia?", ChatMessageType.incoming),
    ChatMessage("like*", ChatMessageType.incoming),
    ChatMessage("yes I do", ChatMessageType.outgoing),
    ChatMessage("what a coincidence, me too!!!", ChatMessageType.incoming)
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
                      return _buildMessage(messages[index]);
                    },
                  )),
                  TextField(
                      decoration: InputDecoration(hintText: 'Send message')),
                ]))));
  }

  _buildMessage(ChatMessage chatMessage) {
    return Column(
      children: <Widget>[
        Align(
          alignment: chatMessage.type == ChatMessageType.incoming
              ? Alignment.centerLeft
              : Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: chatMessage.type == ChatMessageType.incoming
                    ? Colors.deepOrange
                    : Colors.cyan,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(chatMessage.message),
          ),
        ),
      ],
    );
  }
}
