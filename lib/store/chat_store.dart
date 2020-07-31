import 'package:bindchat/network/socket_service.dart';
import 'package:mobx/mobx.dart';
import 'package:bindchat/model/chat_message.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  final SocketService _service;

  @observable
  var messages = ObservableList<ChatMessage>();

  _ChatStore(this._service);

  @action
  void sendMessage(String text) {
    final message = OutgoingMessage(text);

    messages.insert(0, message);
  }
}
