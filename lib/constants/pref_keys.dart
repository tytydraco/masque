/// List of keys for shared preferences.
class PrefKeys {
  /// SharedPreferences key for whether or not to save these login credentials.
  static const saveLoginPrefKey = 'save_login';

  /// SharedPreferences key for the saved screen name.
  static const screenNamePrefKey = 'screen_name';

  /// SharedPreferences key for the saved room id/
  static const roomIdPrefKey = 'room_id';

  /// SharedPreferences key for whether or not input should be limited to one
  /// line.
  static const multilinePrefKey = 'multiline';

  /// SharedPreferences key for whether or not to obscure the room id.
  static const obscureRoomIdPrefKey = 'obscure_room_id';
}
