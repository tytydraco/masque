import 'package:flutter/material.dart';
import 'package:masque/constants/pref_keys.dart';
import 'package:masque/widgets/checkbox_setting_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        CheckboxSettingWidget(
          label: 'Save login information',
          id: saveLoginPrefKey,
          defaultValue: saveLoginDefaultValue,
        ),
        CheckboxSettingWidget(
          label: 'Allow multi-line input',
          id: multilinePrefKey,
          defaultValue: multilineDefaultValue,
        ),
        CheckboxSettingWidget(
          label: 'Obscure room id',
          id: obscureRoomIdPrefKey,
          defaultValue: obscureRoomIdDefaultValue,
        ),
      ],
    );
  }
}
