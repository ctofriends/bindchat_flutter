import 'package:redux/redux.dart';
import 'package:optional/optional.dart';

import 'app_state.dart';
import 'actions.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, ConnectionOpen>(_onSocketConnection),
  TypedReducer<AppState, ConnectionOpening>(_onSocketConnectionOpening),
  TypedReducer<AppState, NewRoom>(_onNewRoom),
  TypedReducer<AppState, NewMessage>(_onNewMessage),
]);

AppState _onSocketConnection(AppState state, ConnectionOpen action) {
  return state.copyWith(connection: Connection.on);
}

AppState _onSocketConnectionOpening(AppState state, ConnectionOpening action) {
  return state.copyWith(connection: Connection.connecting);
}

AppState _onNewRoom(AppState state, NewRoom action) {
  return state.copyWith(room: Optional.of(action.roomName));
}

AppState _onNewMessage(AppState state, NewMessage action) {
  return state.copyWith(messages: state.messages.insert(0, action.message));
}

