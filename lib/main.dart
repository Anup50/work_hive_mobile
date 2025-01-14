import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work_hive_mobile/app/app.dart';
import 'package:work_hive_mobile/view_model/onbord_view_model.dart';
import 'package:work_hive_mobile/view_model/signin_view_model.dart'; // Add the SignInViewModel import
import 'package:work_hive_mobile/view_model/signup_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => OnboardingViewModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignInViewModel(), // Add the SignInViewModel here
        ),
        ChangeNotifierProvider(
          create: (_) => SignUpViewModel(), // Add the SignInViewModel here
        ),
      ],
      child: const MyApp(),
    ),
  );
}
