import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:optional/optional.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'message.dart';

enum Connection { off, connecting, on, error }

class Room {
  final String topic;

  Room(this.topic);
}

class Lobby extends Room {
  Lobby(topic) : super(topic);
}

class None extends Room {
  None() : super("none");
}

class Queue extends Room {
  int count = 0;

  Queue(name, count) : super(name) {
    this.count = count;
  }
}

class Group extends Room {
  Group(topic) : super(topic);
}

class AppState {
  final Connection connection;
  final Room room;
  final IList<Message> messages;
  final String input;
  final String user;

  const AppState({
    this.connection = Connection.off,
    this.room = null,
    this.messages = const IListConst<Message>([]),
    this.input = "",
    this.user = "alan",
  });

  AppState copyWith({connection, room, messages, input, user}) {
    return new AppState(
      connection: connection ?? this.connection,
      room: room ?? this.room,
      messages: messages ?? this.messages,
      input: input ?? this.input,
      user: user ?? this.user,
    );
  }
}
