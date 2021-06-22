import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:optional/optional.dart';

enum Connection {off, connecting, on, error}

class AppState {
  final Connection connection;
  final Optional<dynamic> room;

  const AppState({this.connection = Connection.off, this.room = empty});

  AppState copyWith({connection, room}) {
    return new AppState(
      connection: connection ?? this.connection,
      room: room ?? this.room,
    );
  }
}
