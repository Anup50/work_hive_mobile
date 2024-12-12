import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? fullNameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  bool validateInputs() {
    fullNameError = null;
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;

    if (fullNameController.text.trim().isEmpty) {
      fullNameError = 'Full name is required';
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
      emailError = 'Enter a valid email';
    }

    if (passwordController.text.length < 6) {
      passwordError = 'Password must be at least 6 characters';
    }

    if (confirmPasswordController.text != passwordController.text) {
      confirmPasswordError = 'Passwords do not match';
    }

    notifyListeners();
    return fullNameError == null &&
        emailError == null &&
        passwordError == null &&
        confirmPasswordError == null;
  }

  void signUp() {
    if (validateInputs()) {
      // Add your sign-up logic here
      print('Signed up successfully');
    }
  }
}
