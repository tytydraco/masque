class MessageModel {
  final int timeInMillis;
  final String screenName;
  final String content;

  MessageModel({
    required this.timeInMillis,
    required this.screenName,
    required this.content
  });

  factory MessageModel.now({
    required String screenName,
    required String content
  }) {
    return MessageModel(
      timeInMillis: DateTime.now().millisecondsSinceEpoch,
      screenName: screenName,
      content: content,
    );
  }

  Map<String, dynamic> toMap() => {
    'timestamp': timeInMillis,
    'screenName': screenName,
    'content': content,
  };
}