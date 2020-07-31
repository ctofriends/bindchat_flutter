import 'package:flutter/material.dart';
import 'package:bindchat/network/socket_service.dart';
import 'package:provider/provider.dart';

class TagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);

    return Scaffold(
        backgroundColor: Colors.yellow,
        appBar: AppBar(title: Text('BindChat')),
        body: Container(
            color: Colors.blue,
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(children: <Widget>[
              TextField(
                  decoration: InputDecoration(hintText: 'What do you like?')),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: <Widget>[
                    FlatButton(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Wow',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.bold)),
                            ClipOval(
                                child: Image.asset('assets/images/index.jpg',
                                    height: 90, width: 90))
                          ]),
                      onPressed: () {
                        socketService.joinQueue("Tibia");
                      },
                    ),
                  ],
                ),
              )
            ])));
  }
}
