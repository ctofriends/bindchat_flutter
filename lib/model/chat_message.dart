enum ChatMessageType { incoming, outgoing }

class ChatMessage {
  final String message;
  final ChatMessageType type;

  ChatMessage(this.message, this.type);
}
