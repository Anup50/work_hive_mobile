import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/add_jobseeker_usecase.dart';

import 'repository.mock.dart';

void main() {
  late MockJobSeekerRepository mockJobSeekerRepository;
  late AddJobseekerUsecase addJobseekerUsecase;

  setUp(() {
    mockJobSeekerRepository = MockJobSeekerRepository();
    addJobseekerUsecase = AddJobseekerUsecase(mockJobSeekerRepository);
    registerFallbackValue(const JobSeekerEntity.empty());
  });

  const tUserId = "user123";
  const tProfilePicture = "profile.png";
  const tBio = "A sample bio";
  const tLocation = "New York";
  final tSkills = ["Dart", "Flutter"];

  final tParams = AddJobseekerParams(
    userId: tUserId,
    profilePicture: tProfilePicture,
    bio: tBio,
    location: tLocation,
    skills: tSkills,
  );

  group('AddJobseekerUsecase Tests', () {
    test('should add job seeker data successfully', () async {
      // Arrange
      when(() => mockJobSeekerRepository.addJobSeekerData(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await addJobseekerUsecase(tParams);

      expect(result, const Right(null));
      // Capture the argument passed to addJobSeekerData
      final captured =
          verify(() => mockJobSeekerRepository.addJobSeekerData(captureAny()))
              .captured;
      expect(captured.length, 1);
      final JobSeekerEntity entity = captured.first as JobSeekerEntity;
      expect(entity.userId, tUserId);
      expect(entity.profilePicture, tProfilePicture);
      expect(entity.bio, tBio);
      expect(entity.location, tLocation);
      expect(entity.skills, tSkills);
    });

    test('should return failure when repository fails to add data', () async {
      // Arrange
      const tFailure = ApiFailure(message: "Failed to add data");
      when(() => mockJobSeekerRepository.addJobSeekerData(any()))
          .thenAnswer((_) async => const Left(tFailure));

      // Act
      final result = await addJobseekerUsecase(tParams);

      // Assert
      expect(result, const Left(tFailure));
      verify(() => mockJobSeekerRepository.addJobSeekerData(any())).called(1);
    });
  });
}
