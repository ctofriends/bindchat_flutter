import 'package:mobx/mobx.dart';
import 'package:cdparty_flutter/model/chat_message.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  @observable
  var messages = ObservableList<ChatMessage>();

  @action
  void sendMessage(String message) {
    final chatMessage  = ChatMessage(message, ChatMessageType.outgoing)
    messages.add(chatMessage);
  }
}
