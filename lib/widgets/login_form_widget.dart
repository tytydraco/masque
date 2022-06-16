import 'package:flutter/material.dart';
import 'package:masque/constants/pref_keys.dart';
import 'package:masque/remote/database.dart';
import 'package:masque/utils/field_validators.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginFormWidget extends StatefulWidget {
  final Function(String, String) onLogin;

  const LoginFormWidget({
    Key? key,
    required this.onLogin,
  }) : super(key: key);

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final screenNameController = TextEditingController();
  final roomIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false;

  Future _onLogin() async {
    if (formKey.currentState!.validate()) {
      await setSavedLogin();
      widget.onLogin(
        screenNameController.text,
        roomIdController.text,
      );
    }
  }

  Future _onDeleteRoom() async {
    if (formKey.currentState!.validate()) {
      final dialog = AlertDialog(
        title: const Text('Delete'),
        content: const Text('Are you sure you want to permanently delete this room?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              final database = Database(roomIdController.text);
              setState(() => isLoading = true);
              await database.deleteRoom();
              setState(() => isLoading = false);
            },
            child: const Text('Confirm'),
          ),
        ],
      );
      showDialog(
        context: context,
        builder: (context) => dialog,
      );
    }
  }

  Future loadSavedLogin() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (sharedPrefs.getBool(saveLoginPrefKey) ?? saveLoginDefaultValue) {
      final screenName = sharedPrefs.getString(screenNamePrefKey) ?? '';
      final roomId = sharedPrefs.getString(roomIdPrefKey) ?? '';
      screenNameController.text = screenName;
      roomIdController.text = roomId;
    }
  }

  Future setSavedLogin() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (sharedPrefs.getBool(saveLoginPrefKey) ?? saveLoginDefaultValue) {
      sharedPrefs.setString(screenNamePrefKey, screenNameController.text);
      sharedPrefs.setString(roomIdPrefKey, roomIdController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
      loadSavedLogin();
      return Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  validator: FieldValidators.validateScreenName,
                  controller: screenNameController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Screen name'
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  validator: FieldValidators.validateRoomId,
                  controller: roomIdController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Room id'
                  ),
                  onFieldSubmitted: (_) => _onLogin(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                child: ElevatedButton(
                  onPressed: _onLogin,
                  onLongPress: _onDeleteRoom,
                  child: const Text('Enter'),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
