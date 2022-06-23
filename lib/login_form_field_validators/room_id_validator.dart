import 'package:login_widget/login_field_validator_implementation.dart';

class RoomIdValidator implements LoginFieldValidatorImplementation {
  @override
  String? validate(String? input) {
    if (input == null || input.isEmpty) {
      return 'Required';
    } else if (input.length > 300) {
      return 'Too long';
    } else if (input.contains('/') || input.contains('.')) {
      return 'Invalid characters';
    }
    return null;
  }
}