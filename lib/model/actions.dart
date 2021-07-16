import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';
import 'message.dart';
import 'dart:io';

final PhoenixSocket socket = new PhoenixSocket(
    "ws://localhost:4000/socket/websocket",
    socketOptions: PhoenixSocketOptions(params: {"token": "alan"}));

PhoenixChannel? lobby;
Map<String, PhoenixChannel> channels = {};

class ConnectionOpen {}

class ConnectionOpening {}

class ConnectionError {}

class NewRoom {
  final String room;

  NewRoom(this.room);

  @override
  String toString() {
    return "NewRoom: " + room;
  }
}

class NewMessage {
  final Message message;

  NewMessage(this.message);
}

class NewPresence {
  int presence;
  final String topic;

  NewPresence(this.topic, this.presence);
}

void connect(Store<AppState> store) async {
  if (!socket.isConnected) {
    socket.onOpen(() => store.dispatch(connectionOpen));
    socket.onClose((_) => store.dispatch(ConnectionError()));
    socket.onError((_) => store.dispatch(ConnectionError()));

    socket.connect();
  }
}

void connectionOpen(Store<AppState> store) async {
  store.dispatch(ConnectionOpen());
}

void leaveLobby(Store<AppState> store) async {
  lobby?.leave();
  lobby = null;
  channels.forEach((k, v) => v.leave);
  channels = {};
  store.dispatch(NewRoom("lobby"));
  store.dispatch(ConnectionOpen());
}

void joinLobby(Store<AppState> store) async {
  if (lobby == null) {
    lobby = socket.channel("lobby:" + store.state.user);

    lobby?.on("new_room", (Map? payload, String? _ref, String? _joinRef) {
      if (payload?["room"].startsWith("lobby")) {
        return;
      }
      channels.forEach((k, v) => {
            if (v.topic!.startsWith("queue")) {v.leave()}
          });

      store.dispatch(switchRoom(payload?["room"]));
    });

    lobby?.on("new_msg", (Map? payload, String? _ref, String? _joinRef) {
      store.dispatch(NewMessage(Message(payload?["body"], payload?["sender"])));
    });

    lobby?.join();
  }
  store.dispatch(NewRoom("lobby"));
}

void leaveQueue(Store<AppState> store) async {
  channels[store.state.queue?.topic]?.push(event: "leave", payload: {});

  channels[store.state.queue?.topic]?.leave();

  store.dispatch(joinLobby);
}

ThunkAction<AppState> pushMessage(String message) {
  return (Store<AppState> store) async {
    channels[store.state.group]
        ?.push(event: "post_msg", payload: {"body": message});
  };
}

ThunkAction<AppState> switchRoom(String roomName) {
  return (Store<AppState> store) async {
    PhoenixChannel channel = socket.channel(roomName);

    if (roomName.startsWith("group:")) {
      channel.on("new_msg", (Map? payload, String? _ref, String? _joinRef) {
        store
            .dispatch(NewMessage(Message(payload?["body"], payload?["sender"])));
      });
      channel.on("group_disbanded",
          (Map? payload, String? _ref, String? _joinRef) {
        channels[roomName]?.leave();
        channels.remove(roomName);

        store.dispatch(NewRoom("lobby"));
      });
    } else if (roomName.startsWith("queue")) {
      channel.on("lobby_presence_state",
          (Map? payload, String? _ref, String? _joinRef) {
        store.dispatch(NewPresence(roomName, payload!.keys.length));
      });
      channel.on("queue_presence_state",
          (Map? payload, String? _ref, String? _joinRef) {
        store.dispatch(NewPresence(roomName, payload!.keys.length));
      });
    }

    channels[roomName] = channel;
    channel.join();
    store.dispatch(NewRoom(roomName));
  };
}
