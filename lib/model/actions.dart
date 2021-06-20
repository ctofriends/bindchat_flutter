import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:redux/redux.dart';

import 'app_state.dart';

final PhoenixSocket socket = new PhoenixSocket("ws://localhost:4000/socket/websocket",
  socketOptions: PhoenixSocketOptions(params: {"token": "alan"}));

class ConnectionOpen {}
class ConnectionError {}

void connect(Store<AppState> store) async {

  socket.onOpen(() => store.dispatch(ConnectionOpen()));
  socket.onClose((_) => store.dispatch(ConnectionError()));
  socket.onError((_) => store.dispatch(ConnectionError()));
  
  socket.connect();
}

