class AppValidators {
  AppValidators._();

  //! ---> email validator
  static String? notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return "email is required";
    }
    return null;
  }

  //! ---> email validator
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "email is required";
    }
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return "invalid email address";
    }
    return null;
  }

  //! ---> password validator
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }
    if (value.length < 6) {
      return "password must be at lest 6 characters long.";
    }
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return "password must contains at least one uppercase letter.";
    }
    if (!value.contains(RegExp(r'[0=9]'))) {
      return "password must contains at least one number";
    }
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return "password must contains at least one special character.";
    }
    return null;
  }

  //! ---> phoneNumber validator
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return "Phone number is required";
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return "invalid phone number formate (10 digits required)";
    }
    return null;
  }

  //! ---> name validator
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long.";
    }
    final nameRegExp = RegExp(r'^[a-zA-Z\s]+$');
    if (!nameRegExp.hasMatch(value)) {
      return "Name can only contain letters and spaces.";
    }
    return null;
  }
}
