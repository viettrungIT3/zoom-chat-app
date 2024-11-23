import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/message.dart';
import '../utils/config.dart';

class SocketService {
  late IO.Socket socket;
  final String serverUrl;

  SocketService(this.serverUrl);

  void connect() {
    socket = IO.io(
      serverUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket.connect();
    log('Connected to socket');
  }

  // Hàm lấy tin nhắn cũ
  Future<List<Message>> getMessages(String roomName) async {
    try {
      final response =
          await http.get(Uri.parse('${serverUrl}messages/$roomName'));
      log('response: ${response.body}');
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        log('Parsed data length: ${data.length}');
        return List<Message>.from(data.map((msg) => Message.fromJson(msg)));
      } else {
        log('Error loading messages: ${response.statusCode}');
        throw Exception('Failed to load messages');
      }
    } catch (e) {
      log("Error fetching messages: $e");
      return [];
    }
  }

  void onRoomListUpdate(Function(List<dynamic>) callback) {
    socket.on('room-list-update', (data) {
      callback(data);
    });
  }

  void joinRoom(String roomName) {
    socket.emit('join-room', roomName);
  }

  void leaveRoom(String roomName) {
    socket.emit('leave-room', roomName);
  }

  void sendMessage(String roomName, String message) {
    socket.emit('send-message', {'room': roomName, 'message': message});
  }

  void onMessageReceived(Function(Map<String, dynamic>) callback) {
    socket.on('receive-message', (data) {
      callback(data);
    });
  }

  void onSystemMessage(Function(Map<String, dynamic>) callback) {
    socket.on('user-joined', (data) => callback(data as Map<String, dynamic>));
    socket.on('user-left', (data) => callback(data as Map<String, dynamic>));
  }

  void disconnect() {
    socket.disconnect();
  }
}

final socketService = SocketService(serverUrl);
