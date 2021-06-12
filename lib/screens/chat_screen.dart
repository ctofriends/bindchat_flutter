import 'package:flutter/material.dart';
import 'package:bindchat/model/chat_message.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(title: Text('Tibia')),
        body: SafeArea(
            child: Container(
                color: Colors.blue,
                child: Observer(
                    builder: (_) => Column(children: <Widget>[
                          Expanded(
                              child: ListView.builder(
                            reverse: true,
                            itemCount: 1,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildMessage();
                            },
                          )),
                          _buildSeparator(),
                          _buildMessageComposer()
                        ])))));
  }

  _buildMessage(ChatMessage chatMessage) {
    final isIncomingMessage = (chatMessage is IncomingMessage);
    final color = isIncomingMessage ? Colors.deepOrange : Colors.cyan;
    final alignment =
        isIncomingMessage ? Alignment.centerLeft : Alignment.centerRight;
    return Column(
      children: <Widget>[
        Align(
          alignment: alignment,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Text(chatMessage.message),
          ),
        ),
      ],
    );
  }

  _buildSeparator() {
    return SizedBox(
      height: 10.0,
      child: new Center(
        child: new Container(
          height: 1.0,
          color: Colors.yellow,
        ),
      ),
    );
  }

  _buildMessageComposer() {
    return Container(
        child: Row(children: [
      Expanded(
          child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(5), hintText: 'Send message'),
      )),
      IconButton(
        icon: Icon(Icons.send),
        onPressed: () {
          _controller.clear();
        },
      )
    ]));
  }
}
