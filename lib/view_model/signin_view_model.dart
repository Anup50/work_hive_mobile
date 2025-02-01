// import 'package:flutter/material.dart';
// import 'package:work_hive_mobile/view/home_view.dart';

// class SignInViewModel extends ChangeNotifier {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   String? emailError;
//   String? passwordError;

//   bool validateInputs() {
//     emailError = null;
//     passwordError = null;

//     if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(emailController.text)) {
//       emailError = 'Enter a valid email';
//     }
//     if (passwordController.text.length < 6) {
//       passwordError = 'Password must be at least 6 characters';
//     }

//     notifyListeners();
//     return emailError == null && passwordError == null;
//   }

//   void logIn(BuildContext context) {
//     if (validateInputs()) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => const HomeView()),
//       );
//     }
//   }
// }
