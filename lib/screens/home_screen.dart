import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../model/app_state.dart';
import '../model/actions.dart';

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
                    StoreConnector<AppState, VoidCallback>(converter: (store) {
                      return () => store.dispatch(connect);
                    }, builder: (context, callback) {
                      return Container(
                          decoration: ShapeDecoration(
                              color: Colors.red, shape: CircleBorder()),
                          child: IconButton(
                            color: Colors.white,
                            icon: StoreConnector<AppState, bool>(
                                converter: (store) {
                              return store.state.connection ==
                                  Connection.connecting;
                            }, builder: (context, isConnecting) {
                              return Icon(
                                  isConnecting ? Icons.refresh : Icons.chat);
                            }),
                            onPressed: callback,
                          ));
                    }),
                  ])),
        ),
      ),
    );
  }
}
