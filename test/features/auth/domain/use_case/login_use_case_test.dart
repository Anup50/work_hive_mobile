import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/auth/domain/use_case/login_use_case.dart';

import 'repository.mock.dart';
import 'token.mock.dart';

void main() {
  late MockAuthRepository repository;
  late MockTokenSharedPrefs mockTokenSharedPrefs;
  late LoginUseCase usecase;

  setUp(() {
    repository = MockAuthRepository();
    mockTokenSharedPrefs = MockTokenSharedPrefs();
    usecase = LoginUseCase(repository, mockTokenSharedPrefs);
  });

  const tEmail = 'test@gmail.com';
  const tPassword = 'password@123';
  const tToken = 'sdw2343';

  group('Login Tests', () {
    test('should call login and save token', () async {
      // Arrange
      when(() => repository.loginUser(tEmail, tPassword)).thenAnswer(
        (_) async => const Right(tToken),
      );
      when(() => mockTokenSharedPrefs.saveToken(tToken)).thenAnswer(
        (_) async => const Right(null),
      );
      when(() => mockTokenSharedPrefs.getToken()).thenAnswer(
        (_) async => const Right(tToken),
      );

      // Act
      final result =
          await usecase(const LoginParams(email: tEmail, password: tPassword));

      // Assert
      expect(result, const Right(tToken));
      verify(() => repository.loginUser(tEmail, tPassword)).called(1);
      verify(() => mockTokenSharedPrefs.saveToken(tToken)).called(1);
      verify(() => mockTokenSharedPrefs.getToken()).called(1);
    });

    test('should return failure when login fails', () async {
      // Arrange
      when(() => repository.loginUser(tEmail, tPassword)).thenAnswer(
        (_) async => const Left(ApiFailure(message: 'Invalid credentials')),
      );

      // Act
      final result =
          await usecase(const LoginParams(email: tEmail, password: tPassword));

      // Assert
      expect(result, const Left(ApiFailure(message: 'Invalid credentials')));
      verify(() => repository.loginUser(tEmail, tPassword)).called(1);
      verifyZeroInteractions(mockTokenSharedPrefs);
    });

    test('Failure when email is empty', () async {
      // Arrange
      const emptyEmailData = LoginParams(email: "", password: "password@123");
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "email cannot be empty")));

      // Act
      final result = await usecase(emptyEmailData);

      // Assert
      expect(result, const Left(ApiFailure(message: "email cannot be empty")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
    });

    test('returns Failure when password is empty', () async {
      // Arrange
      const emptyPasswordData =
          LoginParams(email: "test@gmail.com", password: "");
      when(() => repository.loginUser(any(), any())).thenAnswer((_) async =>
          const Left(ApiFailure(message: "Password cannot be empty")));

      // Act
      final result = await usecase(emptyPasswordData);

      // Assert
      expect(
          result, const Left(ApiFailure(message: "Password cannot be empty")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
    });

    test('returns Failure on server error', () async {
      // Arrange
      when(() => repository.loginUser(any(), any())).thenAnswer(
          (_) async => const Left(ApiFailure(message: "Server error")));

      // Act
      final result =
          await usecase(const LoginParams(email: tEmail, password: tPassword));

      // Assert
      expect(result, const Left(ApiFailure(message: "Server error")));
      verify(() => repository.loginUser(any(), any())).called(1);
      verifyNever(() => mockTokenSharedPrefs.saveToken(any()));
    });
  });
}
