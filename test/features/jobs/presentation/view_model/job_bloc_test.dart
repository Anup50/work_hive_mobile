import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:work_hive_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/description_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_all_jobs_usecase.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_job_by_id_usecase.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_recommended_usecase.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/employer_entity.dart';

class MockGetAllJobsUsecase extends Mock implements GetAllJobsUsecase {}

class MockGetJobByIdUsecase extends Mock implements GetJobByIdUsecase {}

class MockGetRecommendedUsecase extends Mock implements GetRecommendedUsecase {}

class MockTokenSharedPrefs extends Mock implements TokenSharedPrefs {}

class GetRecommendedParamsFake extends Fake implements GetRecommendedParams {}

class GetJobByIdParamsFake extends Fake implements GetJobByIdParams {}

void main() {
  late MockGetAllJobsUsecase mockGetAllJobsUsecase;
  late MockGetJobByIdUsecase mockGetJobByIdUsecase;
  late MockGetRecommendedUsecase mockGetRecommendedUsecase;
  late MockTokenSharedPrefs mockTokenSharedPrefs;

  final testJob = JobEntity(
    jobId: '1',
    title: 'Test Job',
    description: const JobDescriptionEntity(
      summary: 'Test Summary',
      responsibilities: ['Test Responsibility'],
    ),
    employer: const EmployerEntity(
      employerId: 'test_employer',
      companyName: 'Test Company',
      location: 'Test Location',
      companyLogo: 'test_logo',
    ),
    location: 'Test Location',
    salary: 50000,
    jobType: 'Full-time',
    experienceLevel: 'Mid',
    datePosted: DateTime.now(),
    deadline: DateTime.now().add(const Duration(days: 30)),
    skillsRequired: const ['Skill 1'],
  );

  setUpAll(() {
    registerFallbackValue(GetRecommendedParamsFake());
    registerFallbackValue(GetJobByIdParamsFake());
  });

  setUp(() {
    mockGetAllJobsUsecase = MockGetAllJobsUsecase();
    mockGetJobByIdUsecase = MockGetJobByIdUsecase();
    mockGetRecommendedUsecase = MockGetRecommendedUsecase();
    mockTokenSharedPrefs = MockTokenSharedPrefs();

    when(() => mockTokenSharedPrefs.getJobSeekerId())
        .thenAnswer((_) async => const Right('test_job_seeker_id'));
  });

  JobBloc buildBloc() => JobBloc(
        getAllJobsUsecase: mockGetAllJobsUsecase,
        getJobByIdUsecase: mockGetJobByIdUsecase,
        getRecommendedUsecase: mockGetRecommendedUsecase,
        tokenSharedPrefs: mockTokenSharedPrefs,
      );

  group('JobBloc', () {
    blocTest<JobBloc, JobState>(
      'emits correct initial sequence',
      build: () {
        when(() => mockGetAllJobsUsecase())
            .thenAnswer((_) async => Right([testJob]));
        when(() => mockGetRecommendedUsecase(any()))
            .thenAnswer((_) async => Right([testJob]));
        return buildBloc();
      },
      wait: const Duration(milliseconds: 100),
      expect: () => [
        JobState.initial().copyWith(isLoading: true), // Initial load
        JobState.initial().copyWith(
            isLoading: false, jobs: [testJob], isLoadingRecommended: true),
        JobState.initial().copyWith(
            isLoading: false,
            jobs: [testJob],
            isLoadingRecommended: false,
            recommendedJobs: [testJob])
      ],
    );

    blocTest<JobBloc, JobState>(
      'emits [loading, loaded] when LoadJobs succeeds',
      build: () {
        reset(mockGetAllJobsUsecase);
        when(() => mockGetAllJobsUsecase())
            .thenAnswer((_) async => Right([testJob]));
        return buildBloc();
      },
      skip: 3, // Skip initial sequence
      act: (bloc) => bloc.add(LoadJobs()),
      expect: () => [
        JobState.initial().copyWith(
            jobs: [testJob], recommendedJobs: [testJob], isLoading: true),
        JobState.initial().copyWith(
            isLoading: false, jobs: [testJob], recommendedJobs: [testJob])
      ],
      verify: (_) => verify(() => mockGetAllJobsUsecase()).called(1),
    );

    blocTest<JobBloc, JobState>(
      'emits [loading, error] when LoadJobs fails',
      build: () {
        reset(mockGetAllJobsUsecase);
        when(() => mockGetAllJobsUsecase()).thenAnswer(
            (_) async => const Left(ServerFailure(message: 'Error')));
        return buildBloc();
      },
      skip: 3, // Skip initial sequence
      act: (bloc) => bloc.add(LoadJobs()),
      expect: () => [
        JobState.initial()
            .copyWith(recommendedJobs: [testJob], isLoading: true),
        JobState.initial().copyWith(
            isLoading: false, error: 'Error', recommendedJobs: [testJob])
      ],
    );
  });
}
