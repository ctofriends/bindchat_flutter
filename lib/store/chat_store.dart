import 'package:mobx/mobx.dart';
import 'package:cdparty_flutter/model/chat_message.dart';
part 'chat_store.g.dart';

class ChatStore = _ChatStore with _$ChatStore;

abstract class _ChatStore with Store {
  @observable
  var messages = ObservableList<ChatMessage>();
  var currentText = Observable("");

  @action
  void inputTextChanged(String text) {
    currentText.value = text;
  }

  @action
  void sendMessage() {
    print("I am sending a message I guess ${currentText.value}");
    final message = ChatMessage(currentText.value, ChatMessageType.outgoing);
    currentText.value = "";
    messages.insert(0, message);
  }
}
