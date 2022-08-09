import 'package:shared_objects/shared_objects.dart';

/// A class to hold instances of all the global shared objects.
class SharedObjects {
  /// The saved screen name.
  final screenName = SharedString('screen_name');

  /// Whether or not to save these login credentials.
  final saveLogin = SharedBool('save_login');

  /// The saved room id.
  final roomId = SharedString('room_id');

  /// Whether or not input should be limited to one line.
  final multiline = SharedBool('multiline');

  /// Whether or not to obscure the room id.
  final obscureRoomId = SharedBool('obscure_room_id');

  /// Set all shared object values to a default value if a value is not yet set.
  Future<void> setDefaultsIfNull() async {
    await screenName.mutate((initial) => initial ?? '');
    await roomId.mutate((initial) => initial ?? '');

    await saveLogin.mutate((initial) => initial ?? true);
    await multiline.mutate((initial) => initial ?? false);
    await obscureRoomId.mutate((initial) => initial ?? true);
  }
}
