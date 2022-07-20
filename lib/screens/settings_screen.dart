import 'package:flutter/material.dart';
import 'package:masque/constants/pref_keys.dart';
import 'package:masque/widgets/checkbox_setting_widget.dart';

/// The user configurable settings screen.
class SettingsScreen extends StatelessWidget {
  /// Create a new [SettingsScreen].
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CheckboxSettingWidget(
          label: 'Save login information',
          id: PrefKeys.saveLoginPrefKey,
        ),
        CheckboxSettingWidget(
          label: 'Allow multi-line input',
          id: PrefKeys.multilinePrefKey,
        ),
        CheckboxSettingWidget(
          label: 'Obscure room id',
          id: PrefKeys.obscureRoomIdPrefKey,
        ),
      ],
    );
  }
}
