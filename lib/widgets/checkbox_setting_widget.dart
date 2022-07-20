import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A checkbox loading and saving changes to [SharedPreferences].
class CheckboxSettingWidget extends StatefulWidget {
  /// Create a new [CheckboxSettingWidget] given a [label] and [id].
  const CheckboxSettingWidget({
    super.key,
    required this.label,
    required this.id,
    this.defaultValue = false,
  });

  /// The description of this checkbox.
  final String label;

  /// The [SharedPreferences] id to use.
  final String id;

  /// The default value to set.
  final bool defaultValue;

  @override
  State<CheckboxSettingWidget> createState() => _CheckboxSettingWidgetState();
}

class _CheckboxSettingWidgetState extends State<CheckboxSettingWidget> {
  Future<bool> _getValue() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(widget.id) ?? widget.defaultValue;
  }

  Future<void> _setValue(bool value) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(widget.id, value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getValue(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final value = snapshot.data! as bool;
          return CheckboxListTile(
            title: Text(widget.label),
            value: value,
            onChanged: (newValue) {
              _setValue(newValue!);
              setState(() {});
            },
          );
        } else {
          return CheckboxListTile(
            title: Text(widget.label),
            value: widget.defaultValue,
            onChanged: null,
          );
        }
      },
    );
  }
}
