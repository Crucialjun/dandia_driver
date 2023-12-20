import 'package:email_validator/email_validator.dart';

class AppTextValidators{
  AppTextValidators._();

  static String? validateEmailOrPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    bool isEmailValid = EmailValidator.validate(value);

    bool isValidPhoneNumber(String? value) =>
        RegExp(r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
            .hasMatch(value ?? '');

    if (!isEmailValid && !isValidPhoneNumber(value)) {
      return 'Please enter a valid email or phone number';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? validateUserName(String? value) {
    //final RegExp nameRegExp = RegExp('[a-zA-Z]');
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }
    if (value.length < 2) {
      return 'Username must be at least 2 characters';
    }
    /**
      if (!nameRegExp.hasMatch(value)) {
        return 'Username must contain only alphabets';
      }
    */
    return null;
  }

  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    }

    bool isEmailValid = EmailValidator.validate(email);

    if (!isEmailValid) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}