abstract class ChatMessage {
  final String message;

  ChatMessage(this.message);
}

class IncomingMessage extends ChatMessage {
  IncomingMessage(String message) : super(message);
}

class OutgoingMessage extends ChatMessage {
  OutgoingMessage(String message) : super(message);
}
