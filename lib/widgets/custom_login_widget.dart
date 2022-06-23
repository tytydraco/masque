import 'package:flutter/material.dart';
import 'package:login_widget/login_form_widget.dart';
import 'package:login_widget/login_field_widget.dart';
import 'package:login_widget/login_widget.dart';
import 'package:masque/constants/pref_keys.dart';
import 'package:masque/remote/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomLoginWidget extends StatefulWidget {
  final Function(String, String) onLogin;

  const CustomLoginWidget({
    Key? key,
    required this.onLogin,
  }) : super(key: key);

  @override
  State<CustomLoginWidget> createState() => _CustomLoginWidgetState();
}

class _CustomLoginWidgetState extends State<CustomLoginWidget> {
  final screenNameController = TextEditingController();
  final roomIdController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var isLoading = false;

  Future _onLogin() async {
    await setSavedLogin();
    widget.onLogin(
      screenNameController.text,
      roomIdController.text,
    );
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

  Future<bool> getObscureRoomId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(obscureRoomIdPrefKey) ?? obscureRoomIdDefaultValue;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    } else {
      loadSavedLogin();
      return Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: FutureBuilder(
          future: getObscureRoomId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final obscure = snapshot.data as bool;
              return LoginWidget(
                form: LoginFormWidget(
                  formKey: formKey,
                  loginFields: [
                    LoginFieldWidget(
                      autofocus: true,
                      hintText: 'Screen name',
                      controller: screenNameController,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Required';
                        } else if (input.length > 64) {
                          return 'Too long';
                        }
                        return null;
                      },
                    ),
                    LoginFieldWidget(
                      hintText: 'Room id',
                      controller: roomIdController,
                      obscureText: obscure,
                      validator: (input) {
                        if (input == null || input.isEmpty) {
                          return 'Required';
                        } else if (input.length > 300) {
                          return 'Too long';
                        } else if (input.contains('/') || input.contains('.')) {
                          return 'Invalid characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                loginButtonText: 'Log in',
                onSubmit: _onLogin,
                onLongPress: _onDeleteRoom,
              );
            } else {
              return Container();
            }
          },
        ),
      );
    }
  }
}
