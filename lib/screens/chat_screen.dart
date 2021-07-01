import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:redux/redux.dart';

import '../model/app_state.dart';
import '../model/actions.dart';
import '../model/message.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreen createState() => _ChatScreen();
}

class _ChatScreen extends State<ChatScreen> {
  final composerController = TextEditingController();

  @override
  void dispose() {
    composerController.dispose();
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
                child: StoreConnector<AppState, IList<Message>>(
                    converter: (store) {
                  return store.state.messages;
                }, builder: (context, messages) {
                  return Column(children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                      reverse: true,
                      itemCount: messages.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildMessage(messages[index]);
                      },
                    )),
                    _buildSeparator(),
                    _buildMessageComposer()
                  ]);
                }))));
  }

  _buildMessage(Message chatMessage) {
    final isIncomingMessage = chatMessage.sender == "alan";
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
            child: Text(chatMessage.value),
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
    return StoreConnector<AppState, Store<AppState>>(converter: (store) {
      return store;
    }, builder: (context, store) {
      return Container(
          child: Row(children: [
        Expanded(
            child: TextFormField(
                controller: composerController,
                onFieldSubmitted: (value) {
                  store.dispatch(pushMessage(value));
                  composerController.text = '';
                },
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5),
                    hintText: 'Send message'))),
        IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              store.dispatch(pushMessage(composerController.text));
              composerController.text = '';
            })
      ]));
    });
  }
}
