import 'package:flutter/material.dart';
import 'package:masque/models/message_model.dart';
import 'package:masque/remote/database.dart';
import 'package:masque/widgets/chat_log_widget.dart';

class ChatScreen extends StatefulWidget {
  final String screenName;
  final String roomId;

  const ChatScreen({
    Key? key,
    required this.screenName,
    required this.roomId
  }) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final Database database;

  @override
  void initState() {
    database = Database(widget.roomId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: database.getMessages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data as List<MessageModel>;
              return ChatLogWidget(messages: data);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
