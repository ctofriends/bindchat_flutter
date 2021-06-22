import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'app_state.dart';
import 'actions.dart';

final reducer = combineReducers<AppState>([
    TypedReducer<AppState, ConnectionOpen>(_onSocketConnection),
    TypedReducer<AppState, ConnectionOpening>(_onSocketConnectionOpening),
    TypedReducer<AppState, NewRoom>(_onNewRoom),
]);

AppState _onSocketConnection(AppState state, ConnectionOpen action) {
  return state.copyWith(connection: Connection.on);
}

AppState _onSocketConnectionOpening(AppState state, ConnectionOpening action) {
  return state.copyWith(connection: Connection.connecting);
}

AppState _onNewRoom(AppState state, NewRoom action) {
  return state.copyWith(inChannel: action.roomName);
}
