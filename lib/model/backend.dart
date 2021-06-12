import 'package:phoenix_wings/phoenix_wings.dart';

class Backend {
  PhoenixSocket socket; 

  Backend() {
    this.socket = new PhoenixSocket("ws://localhost:4000/socket/websocket",
      socketOptions: PhoenixSocketOptions(params: {"token": "alan"}));
  }
}
