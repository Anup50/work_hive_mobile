import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/description_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_all_jobs_usecase.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/employer_entity.dart';

import 'repository.mock.dart';

void main() {
  late GetAllJobsUsecase getAllJobsUsecase;
  late MockJobRepository mockJobRepository;

  setUp(() {
    mockJobRepository = MockJobRepository();
    getAllJobsUsecase = GetAllJobsUsecase(jobRepository: mockJobRepository);
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
        location: 'Kathmandu',
        companyLogo: 'image',
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
        .thenAnswer((_) async => const Left(ServerFailure(message: 'Error')));

    // Act
    final result = await getAllJobsUsecase();

    // Assert
    expect(result, const Left(ServerFailure(message: 'Error')));
    verify(() => mockJobRepository.getJobs()).called(1);
    verifyNoMoreInteractions(mockJobRepository);
  });
}
