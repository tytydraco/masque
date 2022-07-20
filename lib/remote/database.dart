import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masque/models/message_model.dart';

/// Manage the Firestore database given a [roomId].
class Database {
  /// Create a new [Database] given a [roomId].
  Database(this.roomId);

  /// The referenced room id.
  final String roomId;

  /// Delete this room and all messages within it.
  Future<void> deleteRoom() async {
    final db = FirebaseFirestore.instance;
    final collection = db.collection(roomId);

    while (true) {
      final docBatch = await collection.limit(20).get();
      if (docBatch.size == 0) {
        break;
      }
      for (final doc in docBatch.docs) {
        await doc.reference.delete();
      }
    }
  }

  /// Send a [message] to this room.
  Future<void> sendMessage(MessageModel message) async {
    final db = FirebaseFirestore.instance;
    await db.collection(roomId).add(message.toMap());
  }

  /// Yields a [Stream] of messages from this room id.
  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageStream({
    int limit = 100,
  }) async* {
    final db = FirebaseFirestore.instance;
    yield* db
        .collection(roomId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots();
  }
}
