// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:provider/provider.dart';
// import 'package:work_hive_mobile/app/app.dart';
// import 'package:work_hive_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';
// import 'package:work_hive_mobile/features/onboarding/presentation/view_model/onboard_cubit.dart';
// import 'package:work_hive_mobile/features/auth/presentation/bloc/signup_bloc.dart';
// import 'package:work_hive_mobile/view_model/signin_view_model.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         // ViewModel for SignIn
//         ChangeNotifierProvider(
//           create: (_) => SignInViewModel(),
//         ),
//       ],
//       child: MultiBlocProvider(
//         providers: [
//           // Bloc for OnboardingScreen
//           BlocProvider(
//             create: (_) => OnboardingCubit(),
//           ),
//           // Bloc for Signup
//           BlocProvider(
//             create: (_) => SignupBloc(),
//           ),
//         ],
//         child: const MyApp(),
//       ),
//     ),
//   );
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/app/app.dart';
import 'package:work_hive_mobile/app/di/di.dart';
import 'package:work_hive_mobile/core/network/hive_service.dart';
import 'package:work_hive_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:work_hive_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive service (if needed)
  await HiveService.init();

  // Initialize dependencies using GetIt
  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<SignupBloc>(
          create: (_) => getIt<SignupBloc>(),
        ),
        BlocProvider<LoginBloc>(
          create: (_) => getIt<LoginBloc>(),
        ),
        // Add other blocs if necessary
      ],
      child: const MyApp(),
    ),
  );
}
