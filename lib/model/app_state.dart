import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:optional/optional.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'message.dart';

enum Connection { off, connecting, on, error }

class AppState {
  final Connection connection;
  final Optional<dynamic> room;
  final IList<Message> messages;
  final String input;
  final String user;

  const AppState({
    this.connection = Connection.off,
    this.room = empty,
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
