import 'package:bindchat/network/socket_service.dart';
import 'package:mobx/mobx.dart';
part 'home_store.g.dart';

class HomeStore = _HomeStore with _$HomeStore;

abstract class _HomeStore with Store {
  final SocketService _service;

  @observable
  String handle;

  _HomeStore(this._service);

  @action
  handleChanged(String newHandle) {
    handle = newHandle;
  }

  @action
  connect() async {
    await _service.connect(handle);
  }
}
