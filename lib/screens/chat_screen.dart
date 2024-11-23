import 'package:flutter/material.dart';
import '../models/message.dart';
import '../services/socket_service.dart';

class ChatScreen extends StatefulWidget {
  final String roomName;

  const ChatScreen({
    super.key,
    required this.roomName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<Message> messages = [];
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    socketService.joinRoom(widget.roomName);

    socketService.getMessages(widget.roomName).then((loadedMessages) {
      setState(() {
        messages = loadedMessages;
      });

      _scrollToBottom();
    });

    socketService.onMessageReceived((data) {
      setState(() {
        messages.add(Message.fromJson(data));
      });

      _scrollToBottom();
    });

    socketService.onSystemMessage((data) {
      setState(() {
        messages.add(Message.fromJson(data));
      });

      _scrollToBottom();
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      socketService.sendMessage(
          widget.roomName, _messageController.text.trim());
      setState(() {
        messages.add(Message(
          userId: socketService.socket.id ?? 'unknown',
          message: _messageController.text.trim(),
        ));
      });
      _messageController.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void dispose() {
    socketService.leaveRoom(widget.roomName);
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message.userId == socketService.socket.id
                      ? Alignment.centerRight
                      : message.userId == 'SYSTEM'
                          ? Alignment.center
                          : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: message.userId == 'SYSTEM'
                          ? Colors.transparent
                          : (message.userId == socketService.socket.id
                              ? Colors.blue[300]
                              : Colors.green[300]),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.userId == 'SYSTEM'
                          ? message.message
                          : '${message.userId}: ${message.message}',
                      style: TextStyle(
                        color: message.userId == 'SYSTEM'
                            ? Colors.grey
                            : Colors.white,
                        fontSize: message.userId == 'SYSTEM' ? 12 : 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 30,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
