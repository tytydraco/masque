/// Model to contain a message and some metadata.
class MessageModel {
  /// Create a new [MessageModel] given some metadata.
  MessageModel({
    required this.timeInMillis,
    required this.screenName,
    required this.content,
  });

  /// Create a new [MessageModel] from the current time.
  factory MessageModel.now({
    required String screenName,
    required String content,
  }) {
    return MessageModel(
      timeInMillis: DateTime.now().millisecondsSinceEpoch,
      screenName: screenName,
      content: content,
    );
  }

  /// Timestamp of this message.
  final int timeInMillis;

  /// Message sender screen name.
  final String screenName;

  /// Message contents.
  final String content;

  /// Convert this metadata into a map.
  Map<String, dynamic> toMap() => {
        'timestamp': timeInMillis,
        'screenName': screenName,
        'content': content,
      };
}
