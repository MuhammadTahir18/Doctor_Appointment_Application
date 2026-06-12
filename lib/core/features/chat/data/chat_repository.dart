import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'message_model.dart';

class ChatRepository {
  // Apni URL yahan paste karo
  final FirebaseDatabase _database = FirebaseDatabase.instanceFor(
    app: FirebaseDatabase.instance.app,
    databaseURL: 'https://doctorapp-f2422-default-rtdb.firebaseio.com',
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Baaki sab same rehega...
  String get currentUserId => _auth.currentUser!.uid;

  String getChatRoomId(String doctorId) {
    final userId = currentUserId;
    final ids = [userId, doctorId]..sort();
    return ids.join('_');
  }

  Future<void> sendMessage(String doctorId, String message) async {
    final roomId = getChatRoomId(doctorId);
    final ref = _database.ref('chats/$roomId/messages');
    await ref.push().set({
      'senderId': currentUserId,
      'message': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  Stream<List<MessageModel>> getMessages(String doctorId) {
    final roomId = getChatRoomId(doctorId);
    final ref = _database.ref('chats/$roomId/messages');

    return ref.orderByChild('timestamp').onValue.map((event) {
      if (event.snapshot.value == null) return [];

      final data = Map<dynamic, dynamic>.from(
        event.snapshot.value as Map,
      );

      final messages = data.entries.map((entry) {
        return MessageModel.fromMap(
          Map<dynamic, dynamic>.from(entry.value),
          entry.key,
          currentUserId,
        );
      }).toList();

      messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
      return messages;
    });
  }
}