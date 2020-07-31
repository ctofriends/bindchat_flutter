import 'package:mobx/mobx.dart';
import 'package:bindchat/model/chat_message.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  @observable
  var messages = ObservableList<ChatMessage>();

  @action
  void sendMessage(String text) {
    final message = OutgoingMessage(text);

    messages.insert(0, message);
  }
}
