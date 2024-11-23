import 'package:flutter/material.dart';
import '../services/socket_service.dart';

class RoomList extends StatefulWidget {
  const RoomList({super.key});

  @override
  State<RoomList> createState() => _RoomListState();
}

class _RoomListState extends State<RoomList> {
  List<dynamic> rooms = [];

  @override
  void initState() {
    super.initState();
    socketService.connect();

    // Lắng nghe sự kiện cập nhật danh sách phòng
    socketService.onRoomListUpdate((data) {
      setState(() {
        rooms = data;
      });
    });
  }

  void joinRoom(String roomName) {
    Navigator.pushNamed(context, '/chat', arguments: roomName);
  }

  @override
  void dispose() {
    socketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rooms')),
      body: ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return ListTile(
            title: Text('${room['name']} (${room['memberCount']} members)'),
            onTap: () => joinRoom(room['name']),
          );
        },
      ),
    );
  }
}
