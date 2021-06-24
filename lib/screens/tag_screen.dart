import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../model/app_state.dart';
import '../model/actions.dart';

class TagScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 200, height: 200),
                          child: StoreConnector<AppState, VoidCallback>(
                            converter: (store) {
                              return () => store.dispatch(switchRoom("queue:games"));
                            },
                            builder: (context, callback) {
                              return ElevatedButton(
                                child: Text(
                                  'Button',
                                  style: TextStyle(fontSize: 24),
                                ),
                                onPressed: callback,
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                ),
                            );
                          }
                        )
                      )
                    ]
                  )
                )
              ]
            )
          )
        );
      }
    }
