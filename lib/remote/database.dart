import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masque/models/message_model.dart';

class Database {
  final String roomId;

  Database(this.roomId);

  Future sendMessage(MessageModel message) async {
    final db = FirebaseFirestore.instance;
    await db.collection(roomId).add(message.toMap());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessageStream({limit = 100}) async* {
    final db = FirebaseFirestore.instance;
    yield* db
        .collection(roomId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots();
  }
}