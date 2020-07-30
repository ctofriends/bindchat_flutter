import 'package:cdparty_flutter/store/chat_store.dart';
import 'package:flutter/material.dart';
import 'package:cdparty_flutter/model/chat_message.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

final chatStore = ChatStore();

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
                            itemCount: chatStore.messages.length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildMessage(chatStore.messages[index]);
                            },
                          )),
                          _buildSeparator(),
                          _buildMessageComposer()
                        ])))));
  }

  _buildMessage(ChatMessage chatMessage) {
    final color = chatMessage.type == ChatMessageType.incoming
        ? Colors.deepOrange
        : Colors.cyan;
    final alignment = chatMessage.type == ChatMessageType.incoming
        ? Alignment.centerLeft
        : Alignment.centerRight;
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
          chatStore.sendMessage(_controller.text);
          _controller.clear();
        },
      )
    ]));
  }
}
