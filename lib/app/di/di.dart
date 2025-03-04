import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:work_hive_mobile/app/service/sync/sync.dart';
import 'package:work_hive_mobile/app/service/sync/sync_bloc.dart';
import 'package:work_hive_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:work_hive_mobile/core/common/internet_checker.dart';
import 'package:work_hive_mobile/core/network/api_service.dart';
import 'package:work_hive_mobile/core/network/hive_box.dart';
import 'package:work_hive_mobile/core/network/hive_service.dart';
import 'package:work_hive_mobile/features/auth/data/data_source/local_data_source/auth_local_data_source.dart';
import 'package:work_hive_mobile/features/auth/data/data_source/remote_data_source/auth_remote_data_source.dart';
import 'package:work_hive_mobile/features/auth/data/repository/local_repository/auth_local_repository.dart';
import 'package:work_hive_mobile/features/auth/data/repository/remote_repository/auth_remote_repository.dart';
import 'package:work_hive_mobile/features/auth/domain/use_case/login_use_case.dart';
import 'package:work_hive_mobile/features/auth/domain/use_case/register_use_case.dart';
import 'package:work_hive_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:work_hive_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';
import 'package:work_hive_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:work_hive_mobile/features/jobs/data/data_source/remote_data_source/job_remote_data_source.dart';
import 'package:work_hive_mobile/features/jobs/data/repository/job_remote_repository.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_all_jobs_usecase.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_job_by_id_usecase.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_recommended_usecase.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';
import 'package:work_hive_mobile/features/onboarding/presentation/view_model/onboard_cubit.dart';
import 'package:work_hive_mobile/features/user_data/data/data_soure/remote_data_source/job_seeker_remote_data_source.dart';
import 'package:work_hive_mobile/features/user_data/data/repository/job_seeker_remote_repository/job_seeker_remote_repository.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/add_jobseeker_usecase.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/upload_profile_picture.dart';
import 'package:work_hive_mobile/features/user_data/presentation/view_model/bloc/job_seeker_bloc.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await _initHiveService();
  await _initApiService();
  await _initSharedPreferences();
  await _initNetworkService();
  await _initHiveBoxService();

  await _initSyncDependencies();
  await _initJobDependencies();

  await _initHomeDependencies();
  await _initLoginDependencies();
  await _initRegisterDependencies();
  await _initJobSeekerDependencies();
  await _initOnboardingDependencies();
}

Future<void> _initSharedPreferences() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

_initNetworkService() async {
  // Internet Connection Checker
  getIt.registerLazySingleton<InternetConnectionChecker>(
    () => InternetConnectionChecker.createInstance(), // Changed here
  );

  // Register NetworkInfo
  getIt.registerSingleton<NetworkInfo>(
    NetworkInfoImpl(getIt<InternetConnectionChecker>()),
  );
}

_initHiveBoxService() {
  getIt.registerSingleton<HiveBoxManager>(HiveBoxManager());
}

_initHiveService() {
  getIt.registerLazySingleton<HiveService>(() => HiveService());
}

_initApiService() {
  getIt.registerLazySingleton<Dio>(
    () => ApiService(Dio()).dio,
  );
}

_initSyncDependencies() {
  getIt.registerSingleton<SyncService>(
    SyncService(
      networkInfo: getIt<NetworkInfo>(),
      hiveManager: getIt<HiveBoxManager>(),
      dio: getIt<Dio>(),
    ),
  );
  getIt.registerLazySingleton<SyncBloc>(() => SyncBloc(
        syncService: getIt<SyncService>(),
        networkInfo: getIt<NetworkInfo>(),
      ));
}

_initRegisterDependencies() {
  // =========================== Data Source ===========================

  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSource(getIt<HiveService>()),
  );

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSource(
      getIt<Dio>(),
    ),
  );

  // =========================== Repository ===========================
  getIt.registerLazySingleton(
    () => AuthLocalRepository(
      getIt<AuthLocalDataSource>(),
      getIt<NetworkInfo>(),
      getIt<SyncService>(),
      getIt<Dio>(),
    ),
  );
  getIt.registerLazySingleton<AuthRemoteRepository>(
    () => AuthRemoteRepository(
      getIt<AuthRemoteDataSource>(),
      // Added local datasource
      getIt<NetworkInfo>(),
      getIt<AuthLocalDataSource>(),
    ),
  );
  // getIt.registerLazySingleton<AuthRemoteRepository>(
  //   () => AuthRemoteRepository(getIt<AuthRemoteDataSource>(),
  //       getIt<NetworkInfo>(), getIt<AuthLocalDataSource>()),
  // );
  // =========================== Usecases ===========================

  // getIt.registerLazySingleton<RegisterUseCase>(
  //   () => RegisterUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );
  getIt.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCase(
      getIt<AuthRemoteRepository>(),
    ),
  );

  getIt.registerFactory<SignupBloc>(
    () => SignupBloc(
      registerUseCase: getIt(),
    ),
  );
}

_initHomeDependencies() async {
  getIt.registerFactory<HomeCubit>(
    () => HomeCubit(),
  );
}

_initLoginDependencies() async {
  // =========================== Token Shared Preferences ===========================
  getIt.registerLazySingleton<TokenSharedPrefs>(
    () => TokenSharedPrefs(getIt<SharedPreferences>()),
  );
  // =========================== Usecase ===========================
  // getIt.registerLazySingleton<LoginUseCase>(
  //   () => LoginUseCase(
  //     getIt<AuthLocalRepository>(),
  //   ),
  // );

  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(
      getIt<AuthRemoteRepository>(),
      getIt<TokenSharedPrefs>(),
    ),
  );
  getIt.registerFactory<LoginBloc>(
    () => LoginBloc(
      signupBloc: getIt<SignupBloc>(),
      jobSeekerBloc: getIt<JobSeekerBloc>(),
      homeCubit: getIt<HomeCubit>(),
      loginUseCase: getIt<LoginUseCase>(),
    ),
  );
}

_initJobDependencies() {
  // =========================== Data Source ===========================

  getIt.registerFactory<JobRemoteDataSource>(() => JobRemoteDataSource(
      dio: getIt<Dio>(), tokenSharedPrefs: getIt<TokenSharedPrefs>()));

  // =========================== Repository ===========================

  getIt.registerLazySingleton<JobRemoteRepository>(
    () => JobRemoteRepository(
      getIt<JobRemoteDataSource>(),
    ),
  );

  // Usecases

  getIt.registerLazySingleton<GetAllJobsUsecase>(
    () => GetAllJobsUsecase(
      jobRepository: getIt<JobRemoteRepository>(),
    ),
  );
  getIt.registerLazySingleton<GetRecommendedUsecase>(
    () => GetRecommendedUsecase(
      jobRepository: getIt<JobRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<GetJobByIdUsecase>(
    () => GetJobByIdUsecase(
      jobRepository: getIt<JobRemoteRepository>(),
    ),
  );

  // Bloc

  getIt.registerFactory<JobBloc>(
    () => JobBloc(
      getAllJobsUsecase: getIt<GetAllJobsUsecase>(),
      getJobByIdUsecase: getIt<GetJobByIdUsecase>(),
      getRecommendedUsecase: getIt<GetRecommendedUsecase>(),
    ),
  );
}

_initJobSeekerDependencies() {
  // =========================== Data Source ===========================
  getIt.registerLazySingleton<JobSeekerRemoteDataSource>(
    () => JobSeekerRemoteDataSource(getIt<Dio>()),
  );

  // =========================== Repository ===========================
  getIt.registerLazySingleton<JobSeekerRemoteRepository>(
    () => JobSeekerRemoteRepository(getIt<JobSeekerRemoteDataSource>()),
  );

  // =========================== Usecases ===========================
  getIt.registerLazySingleton<AddJobseekerUsecase>(
    () => AddJobseekerUsecase(
      getIt<JobSeekerRemoteRepository>(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      getIt<JobSeekerRemoteRepository>(),
    ),
  );

  // =========================== Bloc ===========================
  getIt.registerFactory<JobSeekerBloc>(
    () => JobSeekerBloc(
      addJobseekerUsecase: getIt<AddJobseekerUsecase>(),
      uploadImageUsecase: getIt<UploadImageUsecase>(),
      homeCubit: getIt<HomeCubit>(),
    ),
  );
}

_initOnboardingDependencies() {
  getIt.registerFactory<OnboardingCubit>(() => OnboardingCubit());
}
