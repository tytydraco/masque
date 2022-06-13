import 'package:flutter/material.dart';
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
        child: ChatLogWidget(roomId: widget.roomId),
      ),
    );
  }
}
