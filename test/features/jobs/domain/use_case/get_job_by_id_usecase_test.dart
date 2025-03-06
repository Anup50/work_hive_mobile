import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/description_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/repository/job_repository.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_all_jobs_usecase.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_job_by_id_usecase.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/employer_entity.dart';

class MockJobRepository extends Mock implements IJobRepository {}

void main() {
  late GetAllJobsUsecase getAllJobsUsecase;
  late GetJobByIdUsecase getJobByIdUsecase;
  late MockJobRepository mockJobRepository;

  setUp(() {
    mockJobRepository = MockJobRepository();
    getAllJobsUsecase = GetAllJobsUsecase(jobRepository: mockJobRepository);
    getJobByIdUsecase = GetJobByIdUsecase(jobRepository: mockJobRepository);
  });

  final jobList = [
    JobEntity(
      jobId: '1',
      title: 'Software Engineer',
      description: const JobDescriptionEntity(
        summary: 'Develop and maintain software.',
        responsibilities: ['Coding', 'Testing'],
      ),
      employer: const EmployerEntity(
        employerId: 'emp1',
        companyName: 'Tech Corp',
        companyLogo: 'Logo',
        location: 'Kathmandu',
      ),
      location: 'Remote',
      salary: 1000,
      jobType: 'Full-time',
      experienceLevel: 'Mid',
      datePosted: DateTime.now(),
      deadline: DateTime.now().add(const Duration(days: 30)),
      skillsRequired: const ['Dart', 'Flutter'],
    ),
  ];

  test('should get a list of JobEntity from the repository', () async {
    // Arrange
    when(() => mockJobRepository.getJobs())
        .thenAnswer((_) async => Right(jobList));

    // Act
    final result = await getAllJobsUsecase();

    // Assert
    expect(result, Right(jobList));
    verify(() => mockJobRepository.getJobs()).called(1);
    verifyNoMoreInteractions(mockJobRepository);
  });

  test('should return a Failure when there is an error', () async {
    // Arrange
    when(() => mockJobRepository.getJobs())
        .thenAnswer((_) async => const Left(ServerFailure(message: 'Failure')));

    // Act
    final result = await getAllJobsUsecase();

    // Assert
    expect(result, const Left(ServerFailure(message: 'Failure')));
    verify(() => mockJobRepository.getJobs()).called(1);
    verifyNoMoreInteractions(mockJobRepository);
  });

  test('should get a JobEntity by ID from the repository', () async {
    // Arrange
    const jobId = '1';
    final job = jobList.first;
    when(() => mockJobRepository.getJob(jobId))
        .thenAnswer((_) async => Right(job));

    // Act
    final result = await getJobByIdUsecase(const GetJobByIdParams(id: jobId));

    // Assert
    expect(result, Right(job));
    verify(() => mockJobRepository.getJob(jobId)).called(1);
    verifyNoMoreInteractions(mockJobRepository);
  });

  test('should return a Failure when getting a job by ID fails', () async {
    // Arrange
    const jobId = '1';
    when(() => mockJobRepository.getJob(jobId)).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'Failed to get ID')));

    // Act
    final result = await getJobByIdUsecase(const GetJobByIdParams(id: jobId));

    // Assert
    expect(result, const Left(ServerFailure(message: 'Failed to get ID')));
    verify(() => mockJobRepository.getJob(jobId)).called(1);
    verifyNoMoreInteractions(mockJobRepository);
  });
}
