import 'package:flutter/material.dart';

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

  void _onLogin() {
    if (formKey.currentState!.validate()) {
      widget.onLogin(
        screenNameController.text,
        roomIdController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Must have a screen name';
                  } else {
                    return null;
                  }
                },
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
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Invalid room id';
                  } else {
                    return null;
                  }
                },
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
                child: const Text('Enter'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
