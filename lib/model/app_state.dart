import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'message.dart';

enum Connection { off, connecting, on, error }

class Room {
  int presence;
  final String topic;

  Room(this.topic, this.presence);
}

class AppState {
  final Connection connection;
  final ISet<Room> rooms;
  final IList<Message> messages;
  final String input;
  final String user;

  const AppState({
    this.connection = Connection.off,
    this.rooms = const ISetConst<Room>({}),
    this.messages = const IListConst<Message>([]),
    this.input = "",
    this.user = "alan",
  });

  AppState copyWith({connection, rooms, messages, input, user}) {
    return new AppState(
      connection: connection ?? this.connection,
      rooms: rooms ?? this.rooms,
      messages: messages ?? this.messages,
      input: input ?? this.input,
      user: user ?? this.user,
    );
  }

  Room? _firstOrNull(topic) {
    for (var r in rooms) {
      if (r.topic.startsWith(topic)) {
        return r;
      }
    }
    ;
    return null;
  }

  Room? get queue {
    _firstOrNull("queue");
  }

  Room? get lobby {
    _firstOrNull("lobby");
  }

  Room? get group {
    _firstOrNull("group");
  }
}
