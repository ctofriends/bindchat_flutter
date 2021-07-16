import 'package:redux/redux.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'app_state.dart';
import 'actions.dart';

final reducer = combineReducers<AppState>([
  TypedReducer<AppState, ConnectionOpen>(_onSocketConnection),
  TypedReducer<AppState, ConnectionOpening>(_onSocketConnectionOpening),
  TypedReducer<AppState, NewRoom>(_onNewRoom),
  TypedReducer<AppState, NewMessage>(_onNewMessage),
  TypedReducer<AppState, NewPresence>(_onNewPresence),
]);

AppState _onSocketConnection(AppState state, ConnectionOpen action) {
  return state.copyWith(connection: Connection.on);
}

AppState _onSocketConnectionOpening(AppState state, ConnectionOpening action) {
  return state.copyWith(connection: Connection.connecting);
}

AppState _onNewRoom(AppState state, NewRoom action) {
  return state;
}

AppState _onNewMessage(AppState state, NewMessage action) {
  return state.copyWith(messages: state.messages.insert(0, action.message));
}

AppState _onNewPresence(AppState state, NewPresence action) {
  ISet<Room> newRooms;
  if (state.rooms.any((r) => r.topic == action.topic)) {
    newRooms = state.rooms
        .removeWhere((r) => r.topic == action.topic)
        .add(Room(action.topic, action.presence));
  } else {
    newRooms = state.rooms.add(Room(action.topic, action.presence));
  }

  return state.copyWith(rooms: newRooms);
}
