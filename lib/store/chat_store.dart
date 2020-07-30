import 'package:mobx/mobx.dart';
import 'package:cdparty_flutter/model/chat_message.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  @observable
  var messages = List<ChatMessage>();

  @action
  void sendMessage(String text) {
    final message = ChatMessage(text, ChatMessageType.outgoing);
    messages.insert(0, message);
  }
}
