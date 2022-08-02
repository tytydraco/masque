import 'package:flutter/material.dart';
import 'package:masque/src/constants/pref_keys.dart';
import 'package:sp_settings/fields/settings_field.dart';
import 'package:sp_settings/fields/switch_settings_field.dart';
import 'package:sp_settings/settings_category.dart';
import 'package:sp_settings/settings_list.dart';

/// The user configurable settings screen.
class SettingsScreen extends StatelessWidget {
  /// Create a new [SettingsScreen].
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        SettingsCategory(
          title: 'Settings',
          settingsList: SettingsList([
            SwitchSettingsField(
              SettingsField(
                title: 'Save login information',
                description: 'Preserve the screen name and room id after '
                    'logging in.',
                icon: Icons.person_add,
              ),
              prefKey: saveLoginPrefKey,
              initialValue: true,
            ),
            SwitchSettingsField(
              SettingsField(
                title: 'Allow multi-line input',
                description: 'Allow submitting lines of text instead of just '
                    'one.',
                icon: Icons.wrap_text,
              ),
              prefKey: multilinePrefKey,
            ),
            SwitchSettingsField(
              SettingsField(
                title: 'Obscure room id',
                description: 'Hide the room id as if it were a password field.',
                icon: Icons.password,
              ),
              prefKey: obscureRoomIdPrefKey,
              initialValue: true,
            ),
          ]),
        )
      ],
    );
  }
}
