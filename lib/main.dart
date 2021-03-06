import 'package:bindchat/screens/home_screen.dart';
import 'package:bindchat/screens/tag_screen.dart';
import 'package:bindchat/screens/chat_screen.dart';
import 'package:bindchat/screens/queue_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'model/app_state.dart';
import 'model/reducer.dart';
import 'model/actions.dart';

final navigatorKey = new GlobalKey<NavigatorState>();

class NavigationMiddleware extends MiddlewareClass<AppState> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationMiddleware(this.navigatorKey);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is NewRoom) {
      String route;

      if (action.room.startsWith('group')) {
        route = '/chat';
      } else if (action.room.startsWith('queue')) {
        route = '/queue';
      } else if (action.room.startsWith('lobby')) {
        route = '/tags';
      } else {
        route = '/';
      }

      navigatorKey.currentState?.pushNamedAndRemoveUntil(route, ModalRoute.withName('/'));
    }

    next(action);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final store = Store<AppState>(reducer,
      middleware: [thunkMiddleware, NavigationMiddleware(navigatorKey)],
      initialState: new AppState());

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
          title: 'BindChat',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.red,
            accentColor: Colors.orange,
          ),
          navigatorKey: navigatorKey,
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
            '/tags': (context) => TagScreen(),
            '/chat': (context) => ChatScreen(),
            '/queue': (context) => QueueScreen(),
          },
        ));
  }
}
