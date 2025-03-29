import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/description_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/repository/job_repository.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/search_jobs_usecase.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/employer_entity.dart';

class MockJobRepository extends Mock implements IJobRepository {}

void main() {
  late SearchJobsUseCase searchJobsUseCase;
  late MockJobRepository mockJobRepository;

  setUp(() {
    mockJobRepository = MockJobRepository();

    searchJobsUseCase = SearchJobsUseCase(mockJobRepository);
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
          companyLogo: 'Techlogo',
          location: 'Kathmandu',
          companyName: 'Bob Inc'),
      location: 'Remote',
      salary: 1000,
      jobType: 'Full-time',
      experienceLevel: 'Mid',
      datePosted: DateTime.now(),
      deadline: DateTime.now().add(const Duration(days: 30)),
      skillsRequired: const ['Dart', 'Flutter'],
    ),
  ];

  test('should search for jobs based on a query', () async {
    // Arrange
    const query = 'Software';
    when(() => mockJobRepository.searchJobs(query))
        .thenAnswer((_) async => Right(jobList));

    // Act
    final result = await searchJobsUseCase(query);

    // Assert
    expect(result, Right(jobList));
    verify(() => mockJobRepository.searchJobs(query)).called(1);
    verifyNoMoreInteractions(mockJobRepository);
  });

  test('should return a Failure when search fails', () async {
    // Arrange
    const query = 'Software';
    when(() => mockJobRepository.searchJobs(query)).thenAnswer(
        (_) async => const Left(ServerFailure(message: 'No matches found')));

    // Act
    final result = await searchJobsUseCase(query);

    // Assert
    expect(result, const Left(ServerFailure(message: 'No matches found')));
    verify(() => mockJobRepository.searchJobs(query)).called(1);
    verifyNoMoreInteractions(mockJobRepository);
  });
}
