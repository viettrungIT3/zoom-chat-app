# Zoom Chat

Zoom Chat is a real-time chat application built using **Flutter** and **Socket.io**.  

---

## Table of contents
1. [Information](#information)
2. [Features](#features)
3. [Technologies](#technologies)
4. [Setup](#setup)
5. [Future Work](#future-work)

---

## Information
```
Flutter 3.24.4 • channel stable • https://github.com/flutter/flutter.git
Framework • revision 603104015d (4 weeks ago) • 2024-10-24 08:01:25 -0700
Engine • revision db49896cf2
Tools • Dart 3.5.4 • DevTools 2.37.3
```

### Structure
```
lib/
 ├── models/
 │   └── message.dart
 │   └── room.dart
 ├── services/
 │   └── socket_service.dart
 ├── screens/
 │   └── room_list_screen.dart
 │   └── chat_screen.dart
 ├── utils/
 │   └── config.dart
 └── main.dart
```

### Screenshots
<div style="display: flex; flex-direction: row; gap: 10px;">
    <img src="https://github.com/user-attachments/assets/dd24bcb1-5cd8-4e7f-a668-ddaa04286e0d" alt="Screenshot 1" width="200">
    <img src="https://github.com/user-attachments/assets/d10a2539-4ff5-45ba-bc75-737fa617c56c" alt="Screenshot 2" width="200">
</div>

---

## Features

1. **Chat Rooms**:
   - Displays a list of available rooms (name + member count).
   - Join or leave a room dynamically.

2. **Real-Time Messaging**:
   - Categorized messages:
     - **Your messages**: Right-aligned.
     - **System messages**: Center-aligned.
     - **Other users' messages**: Left-aligned.
   - Auto-scrolls to the latest message.

---

## Technologies

- **Flutter**: 3.24.4
- **Socket.io**: 4.11.0

---

## Setup

1. Clone the repository
2. Change the `serverUrl` in `lib/utils/config.dart` to your server's URL
3. Install dependencies
4. Run the app

---

## Future Work

1. **Add authentication**
    - Login/Register
    - Store user data in `SharedPreferences`
    - Show username instead of IP address
2. **Add a nice UI/UX**
    - Add a nice loading screen
    - Add a nice error screen
    - Improve the room list design
    - Improve the chat design
    - Improve the overall design
3. **Push notifications**
    - Notify user when they receive a new message
4. **Add more features**
    - Add typing indicator
    - Add reactions
    - Add file sharing
