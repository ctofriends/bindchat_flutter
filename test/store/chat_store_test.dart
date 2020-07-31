import 'package:flutter_test/flutter_test.dart';
import 'package:bindchat/model/chat_message.dart';
import 'package:bindchat/store/chat_store.dart';
import 'package:mobx/mobx.dart';

void main() {
  test('sendMessage should append message to messages list', () {
    final sut = ChatStore();
    sut.sendMessage("Hi");
    expect(sut.messages.length, 1);
    expect(sut.messages[0].message, "Hi");
    expect(sut.messages[0].runtimeType, OutgoingMessage);
  });

  test('sendMessage should append messages to the start of the list', () {
    final sut = ChatStore();
    sut.messages = ObservableList.of([IncomingMessage("Hi")]);
    sut.sendMessage("Bye");
    expect(sut.messages.length, 2);
    expect(sut.messages[0].message, "Bye");
    expect(sut.messages[0].runtimeType, OutgoingMessage);
  });
}
