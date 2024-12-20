import 'package:flutter/material.dart';
import 'package:work_hive_mobile/core/app_theme/app_theme.dart';
import 'package:work_hive_mobile/view/onboard_screen_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const OnboardingScreen(),
      theme: getApplicationTheme(),
      
    );
  }
}