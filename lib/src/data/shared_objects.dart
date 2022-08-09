import 'package:shared_objects/shared_objects.dart';

/// A class to hold instances of all the global shared objects.
class SharedObjects {
  /// SharedPreferences key for [screenName].
  static const screenNamePrefKey = 'screen_name';

  /// SharedPreferences key for [roomId].
  static const roomIdPrefKey = 'room_id';

  /// SharedPreferences key for [saveLogin].
  static const saveLoginPrefKey = 'save_login';

  /// SharedPreferences key for [multiline].
  static const multilinePrefKey = 'multiline';

  /// SharedPreferences key for [obscureRoomId].
  static const obscureRoomIdPrefKey = 'obscure_room_id';

  /// The saved screen name.
  final screenName = SharedString(screenNamePrefKey);

  /// The saved room id.
  final roomId = SharedString(roomIdPrefKey);

  /// Whether or not to save these login credentials.
  final saveLogin = SharedBool(saveLoginPrefKey);

  /// Whether or not input should be limited to one line.
  final multiline = SharedBool(multilinePrefKey);

  /// Whether or not to obscure the room id.
  final obscureRoomId = SharedBool(obscureRoomIdPrefKey);

  /// Set all shared object values to a default value if a value is not yet set.
  Future<void> setDefaultsIfNull() async {
    await screenName.mutate((initial) => initial ?? '');
    await roomId.mutate((initial) => initial ?? '');

    await saveLogin.mutate((initial) => initial ?? true);
    await multiline.mutate((initial) => initial ?? false);
    await obscureRoomId.mutate((initial) => initial ?? true);
  }
}
