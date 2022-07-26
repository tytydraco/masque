/// Holds the current session's [displayName] and [roomId].
class SessionModel {
  /// Creates a new [SessionModel] given a [displayName] and a [roomId].
  SessionModel({
    required this.displayName,
    required this.roomId,
  });

  /// The user's display name.
  final String displayName;

  /// The active room id.
  final String roomId;
}
