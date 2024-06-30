import 'package:firebase_database/firebase_database.dart';

class RoomController {
  final DatabaseReference _database = FirebaseDatabase(
    databaseURL:
        "https://voxbox-project-default-rtdb.asia-southeast1.firebasedatabase.app",
  ).ref();

  Future<String> createRoom(String roomName) async {
    try {
      DatabaseReference roomRef = _database.child('rooms').push();
      await roomRef.set({
        'roomName': roomName,
        'createdAt': DateTime.now().toIso8601String(),
      });
      return roomRef.key ?? '';
    } catch (e) {
      print('Error creating room: $e');
      return '';
    }
  }

  Future<bool> joinRoom(String roomId) async {
    try {
      DatabaseReference roomRef = _database.child('rooms').child(roomId);
      DataSnapshot snapshot = await roomRef.get();

      if (snapshot.exists) {
        print('Room exists with roomId: $roomId');
        return true;
      } else {
        print('Room does not exist with roomId: $roomId');
        return false;
      }
    } catch (e) {
      print('Error joining room: $e');
      return false;
    }
  }
}
