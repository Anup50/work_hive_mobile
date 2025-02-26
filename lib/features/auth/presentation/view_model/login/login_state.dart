part of 'login_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

class LoginState {
  final bool isLoading;
  final bool isSuccess;
  final AuthStatus authStatus;

  LoginState(
      {required this.isLoading,
      required this.isSuccess,
      required this.authStatus});

  LoginState.initial()
      : isLoading = false,
        isSuccess = false,
        authStatus = AuthStatus.unauthenticated;

  LoginState copyWith({
    bool? isLoading,
    bool? isSuccess,
    AuthStatus? authStatus,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
