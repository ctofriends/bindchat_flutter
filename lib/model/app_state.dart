import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:optional/optional.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

enum Connection {off, connecting, on, error}

class AppState {
  final Connection connection;
  final Optional<dynamic> room;
  final IList<String> messages;

  const AppState({this.connection = Connection.off, this.room = empty, this.messages = const IListConst<String>([])});

  AppState copyWith({connection, room, messages}) {
    return new AppState(
      connection: connection ?? this.connection,
      room: room ?? this.room,
      messages: messages ?? this.messages,
    );
  }
}
