import 'package:shared_objects/shared_objects.dart';

/// A class to hold instances of all the global shared objects.
class SharedObjects {
  /// Whether or not to save these login credentials.
  final saveLogin = SharedBool('save_login');

  /// The saved screen name.
  final screenName = SharedString('screen_name');

  /// The saved room id.
  final roomId = SharedStringList('room_id');

  /// Whether or not input should be limited to one line.
  final multiline = SharedBool('multiline');

  /// Whether or not to obscure the room id.
  final obscureRoomId = SharedBool('obscure_room_id');
}
