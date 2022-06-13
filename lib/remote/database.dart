import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:masque/models/message_model.dart';

class Database {
  final String roomId;

  Database(this.roomId);

  Future sendMessage(MessageModel message) async {
    final db = FirebaseFirestore.instance;
    await db.collection(roomId).add(message.toMap());
  }
}