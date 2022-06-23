import 'package:login_widget/login_field_validator_implementation.dart';

class ScreenNameValidator implements LoginFieldValidatorImplementation {
  @override
  String? validate(String? input) {
    if (input == null || input.isEmpty) {
      return 'Required';
    } else if (input.length > 64) {
      return 'Too long';
    }
    return null;
  }
}