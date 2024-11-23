import 'package:flutter/material.dart';

import 'screens/chat_screen.dart';
import 'screens/room_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => RoomList(),
        '/chat': (context) => ChatScreen(
              roomName: ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}
