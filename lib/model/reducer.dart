import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';

import 'app_state.dart';
import 'actions.dart';

final reducer = combineReducers<AppState>([
    TypedReducer<AppState, ConnectionOpen>(_onSocketConnection),
]);

AppState _onSocketConnection(AppState state, ConnectionOpen action) {
  return state.copyWith(connectionState: ConnectionState.on);
}


