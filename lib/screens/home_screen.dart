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
  Widget _logo() {
    return Text(
      'BindChat',
      style: TextStyle(
          color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold),
      );
  }

  Widget _input() {
    return TextField(
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.red,
          hintStyle: TextStyle(color: Colors.white),
          hintText: '@handle'),
    );
  }

  Widget _button() {
    return StoreConnector<AppState, VoidCallback>(converter: (store) {
      if (store.state.connection == Connection.off) {
        return () => store.dispatch(connect);
      } else {
        return () => store.dispatch(joinLobby);
      }
    }, builder: (context, callback) {
      return Container(
          decoration: ShapeDecoration(color: Colors.red, shape: CircleBorder()),
          child: IconButton(
            color: Colors.white,
            icon: StoreConnector<AppState, IconData>(converter: (store) {
              switch (store.state.connection) {
                case Connection.connecting:
                  return Icons.refresh;
                  break;
                case Connection.on:
                  return Icons.insert_link;
                  break;
                default:
                  return Icons.shortcut;
              }
            }, builder: (context, icon) {
              return Icon(icon);
            }),
            onPressed: callback,
          ));
    });
  }

  Widget _column() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _logo(),
          _input(),
          _button(),
        ]);
  }

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
                child: _column()),
          ),
        ));
  }
}
