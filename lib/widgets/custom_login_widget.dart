import 'package:flutter/material.dart';
import 'package:login_widget/login_field_widget.dart';
import 'package:login_widget/login_form_widget.dart';
import 'package:login_widget/login_widget.dart';
import 'package:masque/constants/pref_keys.dart';
import 'package:masque/models/session_model.dart';
import 'package:masque/remote/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A login widget using the [LoginWidget] package.
class CustomLoginWidget extends StatefulWidget {
  /// Create a new [CustomLoginWidget] given an [onSubmit] callback.
  const CustomLoginWidget({
    super.key,
    required this.onSubmit,
  });

  /// Callback given a [SessionModel] once logged in.
  final void Function(SessionModel session) onSubmit;

  @override
  State<CustomLoginWidget> createState() => _CustomLoginWidgetState();
}

class _CustomLoginWidgetState extends State<CustomLoginWidget> {
  final _screenNameController = TextEditingController();
  final _roomIdController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isLoading = false;

  Future<String?> _onLogin() async {
    await setSavedLogin();
    widget.onSubmit(
      SessionModel(
        screenName: _screenNameController.text,
        roomId: _roomIdController.text,
      ),
    );
    return null;
  }

  Future<String?> _onDeleteRoom() async {
    if (_formKey.currentState!.validate()) {
      final dialog = AlertDialog(
        title: const Text('Delete'),
        content: const Text(
          'Are you sure you want to permanently delete this room?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              final database = Database(_roomIdController.text);
              setState(() => _isLoading = true);
              await database.deleteRoom();
              setState(() => _isLoading = false);
            },
            child: const Text('Confirm'),
          ),
        ],
      );
      await showDialog<void>(
        context: context,
        builder: (context) => dialog,
      );
    }
    return null;
  }

  Future<void> loadSavedLogin() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (sharedPrefs.getBool(saveLoginPrefKey) ?? true) {
      final screenName = sharedPrefs.getString(screenNamePrefKey) ?? '';
      final roomId = sharedPrefs.getString(roomIdPrefKey) ?? '';
      _screenNameController.text = screenName;
      _roomIdController.text = roomId;
    }
  }

  Future<void> setSavedLogin() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    if (sharedPrefs.getBool(saveLoginPrefKey) ?? true) {
      await sharedPrefs.setString(
        screenNamePrefKey,
        _screenNameController.text,
      );
      await sharedPrefs.setString(
        roomIdPrefKey,
        _roomIdController.text,
      );
    }
  }

  Future<bool> getObscureRoomId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(obscureRoomIdPrefKey) ?? true;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const CircularProgressIndicator();
    } else {
      loadSavedLogin();
      return Container(
        constraints: const BoxConstraints(maxWidth: 300),
        child: FutureBuilder(
          future: getObscureRoomId(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final obscure = snapshot.data! as bool;
              return LoginWidget(
                form: LoginFormWidget(
                  formKey: _formKey,
                  loginFields: [
                    LoginFieldWidget(
                      autofocus: true,
                      hintText: 'Screen name',
                      controller: _screenNameController,
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
                      controller: _roomIdController,
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
