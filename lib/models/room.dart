class Room {
  final String name;
  final int memberCount;

  Room({required this.name, required this.memberCount});

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      name: json['name'],
      memberCount: json['memberCount'],
    );
  }
}
