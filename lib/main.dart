import 'package:bindchat/screens/home_screen.dart';
import 'package:bindchat/screens/tag_screen.dart';
import 'package:bindchat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'model/app_state.dart';
import 'model/reducer.dart';
import 'model/actions.dart';

final navigatorKey = new GlobalKey<NavigatorState>();

class MyMiddleware extends MiddlewareClass<AppState> {
  final GlobalKey<NavigatorState> navigatorKey;

  MyMiddleware(this.navigatorKey);
  
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is NewRoom && action.inGroup) {
      navigatorKey.currentState.pushNamed('/chat');
    } else {
      navigatorKey.currentState.pushNamed('/tags');
    }
  }
}

final store = Store<AppState>(reducer, middleware: [thunkMiddleware, MyMiddleware(navigatorKey)], initialState: new AppState());

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
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
          onGenerateRoute: (settings) {
            final arguments = settings.arguments;
            switch (settings.name) {
              case '/tags':
                return MaterialPageRoute(
                  builder: (context) => TagScreen(),
                );
                break;
                case '/chat':
                return MaterialPageRoute(
                  builder: (context) => ChatScreen(),
                );
                break;
              default:
                break;
            }
          },
          initialRoute: '/',
          routes: {
            '/': (context) => HomeScreen(),
          },
        ));
  }
}
