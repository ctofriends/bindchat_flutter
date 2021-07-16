import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../model/app_state.dart';
import '../model/actions.dart';

class QueueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, VoidCallback>(converter: (store) {
      return () => store.dispatch(leaveLobby);
    }, builder: (context, callback) {
      return WillPopScope(
          onWillPop: () async {
            callback();
            return true;
          },
          child: Scaffold(
              backgroundColor: Colors.yellow,
              appBar: AppBar(title: Text('BindChat')),
              body: StoreConnector<AppState, Room?>(converter: (store) {
                return store.state.queue;
              }, builder: (context, room) {
                return Container(
                    color: Colors.red,
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    child: Column(children: <Widget>[
                      Text(room?.presence.toString() ?? "no presence"),
                      Expanded(
                          child: GridView.count(
                              crossAxisCount: 2,
                              children: <Widget>[
                            ConstrainedBox(
                                constraints: BoxConstraints.tightFor(
                                    width: 200, height: 200),
                                child: StoreConnector<AppState, VoidCallback>(
                                    converter: (store) {
                                  return () => store.dispatch(leaveQueue);
                                }, builder: (context, callback) {
                                  return ElevatedButton(
                                    child: Text(
                                      'Leave Queue',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                    onPressed: callback,
                                    style: ElevatedButton.styleFrom(
                                      shape: CircleBorder(),
                                    ),
                                  );
                                }))
                          ]))
                    ]));
              })));
    });
  }
}
