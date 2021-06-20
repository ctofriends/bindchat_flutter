import 'package:phoenix_wings/phoenix_wings.dart';

enum ConnectionState {off, on, error}

class AppState {
  final ConnectionState connectionState;

  const AppState({this.connectionState = ConnectionState.off});

  AppState copyWith({connectionState}) {
    return new AppState(
      connectionState: connectionState ?? this.connectionState,
    );
  }
}
