import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:rxdart/subjects.dart';

class SocketService {
  PhoenixSocket socket;
  var router = BehaviorSubject<String>();

  connect(String handle) async {
    socket = PhoenixSocket("ws://localhost:4000/socket/websocket",
        socketOptions: PhoenixSocketOptions(params: {"token": handle}));
    await socket.connect();
    final lobby = socket.channel("lobby");
    lobby.join();
    lobby.on("new_room", (payload, ref, joinRef) {
      if (payload["room"] is String) {
        router.add(payload["room"] as String);
      }
    });
  }

  joinQueue(String tag) async {
    print("joining queue $tag");
    final queue = socket.channel("queue:$tag");
    queue.join();
    queue.on("new_room", (payload, ref, joinRef) {
      if (payload["room"] is String) {
        router.add(payload["room"] as String);
      }
    });
  }
}
