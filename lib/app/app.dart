import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/app/di/di.dart';
import 'package:work_hive_mobile/core/app_theme/app_theme.dart';
import 'package:work_hive_mobile/features/onboarding/presentation/view/onboard_screen_view.dart';
import 'package:work_hive_mobile/features/onboarding/presentation/view_model/onboard_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getApplicationTheme(),
        home: BlocProvider.value(
          value: getIt<OnboardingCubit>(),
          child: const OnboardingScreen(),
        ));
  }
}
