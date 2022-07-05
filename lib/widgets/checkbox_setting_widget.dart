import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckboxSettingWidget extends StatefulWidget {
  final String label;
  final String id;
  final bool defaultValue;

  const CheckboxSettingWidget({
    Key? key,
    required this.label,
    required this.id,
    this.defaultValue = false,
  }) : super(key: key);

  @override
  State<CheckboxSettingWidget> createState() => _CheckboxSettingWidgetState();
}

class _CheckboxSettingWidgetState extends State<CheckboxSettingWidget> {
  Future<bool> _getValue() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(widget.id) ?? widget.defaultValue;
  }

  Future _setValue(bool value) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool(widget.id, value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getValue(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final value = snapshot.data as bool;
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
