import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/upload_profile_picture.dart';

import 'repository.mock.dart';

void main() {
  late MockJobSeekerRepository repository;
  late UploadImageUsecase usecase;

  setUp(() {
    repository = MockJobSeekerRepository();
    usecase = UploadImageUsecase(repository);
    registerFallbackValue(File('path/to/file'));
  });

  final file = File('path/to/file');

  test(
      'should call [JobSeekerRepo.uploadProfilePicture] and return the uploaded image name',
      () async {
    // Arrange
    const uploadedImageName = 'profile_picture.png';

    when(() => repository.uploadProfilePicture(file))
        .thenAnswer((_) async => const Right(uploadedImageName));

    // Act
    final result = await usecase(UploadImageParams(file: file));

    // Assert
    expect(result, const Right(uploadedImageName));

    // Verify that the repository method was called once
    verify(() => repository.uploadProfilePicture(file)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return failure when upload fails', () async {
    // Arrange
    const failureMessage = 'Upload failed';
    const failure = ApiFailure(message: failureMessage);
    when(() => repository.uploadProfilePicture(file))
        .thenAnswer((_) async => const Left(failure));

    // Act
    final result = await usecase(UploadImageParams(file: file));

    // Assert
    expect(result, const Left(failure));

    // Verify that the method was called once
    verify(() => repository.uploadProfilePicture(file)).called(1);
    verifyNoMoreInteractions(repository);
  });
}
