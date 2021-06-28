import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'message.dart';
import 'dart:io';

final PhoenixSocket socket = new PhoenixSocket(
    "ws://localhost:4000/socket/websocket",
    socketOptions: PhoenixSocketOptions(params: {"token": "alan"}));

PhoenixChannel channel;

class ConnectionOpen {}

class ConnectionOpening {}

class ConnectionError {}

class NewRoom {
  final String _roomName;

  get roomName {
    return this._roomName;
  }

  get inGroup {
    return this._roomName.startsWith("group");
  }

  NewRoom(this._roomName);
}

class NewMessage {
  final Message message;

  NewMessage(this.message);
}

void connect(Store<AppState> store) async {
  if (!socket.isConnected) {
    socket.onOpen(() => store.dispatch(connectionOpen));
    socket.onClose((_) => store.dispatch(ConnectionError()));
    socket.onError((_) => store.dispatch(ConnectionError()));

    await socket.connect();
  } else {
    store.dispatch(NewRoom(store.state.room.value));
  }
}

void connectionOpen(Store<AppState> store) async {
  store.dispatch(ConnectionOpen());
  store.dispatch(joinLobby);
}

void joinLobby(Store<AppState> store) async {
  channel = socket.channel("lobby");
  channel.on("new_room", (Map payload, String _ref, String _joinRef) {
    store.dispatch(switchRoom(payload["room"]));
  });
  channel.join();
}

ThunkAction<AppState> switchRoom(String roomName) {
  return (Store<AppState> store) async {
    if (roomName != "lobby") {
      channel = socket.channel(roomName);

      if (roomName.startsWith("queue:")) {
        channel.on("new_room", (Map payload, String _ref, String _joinRef) {
          store.dispatch(switchRoom(payload["room"]));
        });
      } else if (roomName.startsWith("group:")) {
        channel.on("new_msg", (Map payload, String _ref, String _joinRef) {
          store.dispatch(
              NewMessage(Message(payload["body"], payload["sender"])));
        });
      }

      channel.join();
      store.dispatch(NewRoom(roomName));
    }
  };
}

void pushMessage(Store<AppState> store) async {
  final push = PhoenixPush(channel, store.state.input, {}, 100);
  push.send;
}
