import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/auth/domain/entity/auth_enity.dart';
import 'package:work_hive_mobile/features/auth/domain/use_case/register_use_case.dart';

import 'repository.mock.dart';

void main() {
  late MockAuthRepository repository;
  late RegisterUseCase usecase;

  setUp(() {
    repository = MockAuthRepository();
    usecase = RegisterUseCase(repository);
    registerFallbackValue(const AuthEntity(
      name: 'Anup KC',
      email: 'test@gmail.com',
      password: 'password@123',
      role: '1',
    ));
  });

  const registerParams = RegisterUserParams(
    name: 'Anup KC',
    email: 'test2@gmail.com',
    password: 'password@123',
    role: '1',
  );

  group('Register Tests', () {
    test('should return Failure when email is already in use', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Email is already registered")));

      // Act
      final result = await usecase(registerParams);

      // Assert
      expect(result,
          const Left(ApiFailure(message: "Email is already registered")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should return Failure when required fields are missing', () async {
      // Arrange
      const invalidParams = RegisterUserParams(
        name: 'Anup KC',
        email: 'test@gmail.com',
        password: 'password@123',
        role: '',
      );

      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "One or more credentials are empty")));

      // Act
      final result = await usecase(invalidParams);

      // Assert
      expect(result,
          const Left(ApiFailure(message: "One or more credentials are empty")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should return Failure when there is Api Failure', () async {
      // Arrange
      when(() => repository.registerUser(any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Unexpected server error")));

      // Act
      final result = await usecase(registerParams);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Unexpected server error")));
      verify(() => repository.registerUser(any())).called(1);
    });

    test('should successfully register a user and return Right(null)',
        () async {
      // Arrange
      when(() => repository.registerUser(any()))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(registerParams);

      // Assert
      expect(result, const Right(null));
      verify(() => repository.registerUser(any())).called(1);
      verifyNoMoreInteractions(repository);
    });
  });
}
