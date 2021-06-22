import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';

final PhoenixSocket socket = new PhoenixSocket("ws://localhost:4000/socket/websocket",
  socketOptions: PhoenixSocketOptions(params: {"token": "alan"}));

PhoenixChannel channel;

class ConnectionOpen {}
class ConnectionOpening {}
class ConnectionError {}
class NewRoom {
  final String roomName;

  NewRoom(this.roomName);
}
class NewMessage{
  final String message;

  NewMessage(this.message);
}

void connect(Store<AppState> store) async {
  if (!socket.isConnected) {
    socket.onOpen(() => store.dispatch(connectionOpen));
    socket.onClose((_) => store.dispatch(ConnectionError()));
    socket.onError((_) => store.dispatch(ConnectionError()));
    
    await socket.connect();
  }
}

void connectionOpen(Store<AppState> store) async {
  store.dispatch(ConnectionOpen());
  store.dispatch(joinLobby); 
}

void joinLobby(Store<AppState> store) async {
  channel = socket.channel("lobby");
  channel.on("new_room", (Map payload, String _ref, String _joinRef) {
      store.dispatch(switchRoom(payload.toString()));
  });
  channel.join();
}

ThunkAction<AppState> switchRoom(String roomName) {
  return (Store<AppState> store) async {
    if (store.state.room != roomName) {
      channel.leave();
      channel = socket.channel(roomName);

      if (roomName == "lobby") {
        channel.on("new_room", (Map payload, String _ref, String _joinRef) {
            store.dispatch(switchRoom(payload.toString()));
        });
      } else if (roomName.startsWith("queue:")) {
        
      }
      else if (roomName.startsWith("group:")) {
        channel.on("new_message", (Map payload, String _ref, String _joinRef) {
            store.dispatch(switchRoom(payload.toString()));
        });
      }

      channel.join();
    }
  };
}
