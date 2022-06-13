import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masque/models/message_model.dart';

class Database {
  final String roomId;

  Database(this.roomId);

  Future<List<MessageModel>> getMessages() async {
    final db = FirebaseFirestore.instance;
    final query = await db.collection(roomId).get();
    return query.docs.map((e) {
      final data = e.data();
      return MessageModel(
        timeInMillis: data['timestamp'],
        screenName: data['screenName'],
        content: data['content'],
      );
    }).toList();
  }

  Future sendMessage(MessageModel message) async {
    final db = FirebaseFirestore.instance;
    await db.collection(roomId).add(message.toMap());
  }
}