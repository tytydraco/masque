class FieldValidators {
  static String? validateScreenName(String? input) {
    if (input == null || input.isEmpty) {
      return 'Required';
    } else if (input.length > 64) {
      return 'Too long';
    } else {
      return null;
    }
  }

  static String? validateRoomId(String? input) {
    if (input == null || input.isEmpty) {
      return 'Required';
    } else if (input.length > 300) {
      return 'Too long';
    } else if (input.contains('/') || input.contains('.')) {
      return 'Invalid characters';
    } else {
      return null;
    }
  }

  static String? validateMessage(String? input) {
    if (input == null || input.isEmpty) {
      return 'Required';
    } else if (input.length > 2000) {
      return 'Too long';
    } else {
      return null;
    }
  }
}