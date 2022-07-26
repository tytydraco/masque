/// Holds the current session's [screenName] and [roomId].
class SessionModel {
  /// Creates a new [SessionModel] given a [screenName] and a [roomId].
  SessionModel({
    required this.screenName,
    required this.roomId,
  });

  /// The user's display name.
  final String screenName;

  /// The active room id.
  final String roomId;
}
