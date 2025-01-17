import 'package:get_it/get_it.dart';
import 'package:work_hive_mobile/core/network/hive_service.dart';
import 'package:work_hive_mobile/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:work_hive_mobile/features/auth/data/repository/local_repository/auth_local_repository.dart';
import 'package:work_hive_mobile/features/auth/domain/use_case/login_use_case.dart';
import 'package:work_hive_mobile/features/auth/domain/use_case/register_use_case.dart';
import 'package:work_hive_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:work_hive_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';
import 'package:work_hive_mobile/features/onboarding/presentation/view_model/onboard_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  // First initialize hive service
  await _initHiveService();

  // Initialize the onboarding cubit and other dependencies
  await _initOnboardingDependencies();
  await _initRegisterDependencies();
  await _initLoginDependencies();
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initOnboardingDependencies() {
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
}

_initRegisterDependencies() {
  // init local data source
  getIt.registerLazySingleton(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  // init local repository
  getIt.registerLazySingleton(
    () => AuthLocalRepository(getIt<AuthLocalDataSource>()),
  );

  // register use usecase
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<SignupBloc>(
    () => SignupBloc(
      registerUseCase: getIt(),
    ),
  );
}

_initLoginDependencies() async {
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthLocalRepository>(),
    ),
  );

  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      signupBloc: getIt<SignupBloc>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}
