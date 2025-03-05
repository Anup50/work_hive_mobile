import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/features/auth/domain/use_case/login_use_case.dart';
import 'package:work_hive_mobile/features/auth/presentation/view_model/signup/signup_bloc.dart';
import 'package:work_hive_mobile/features/home/presentation/view/home_view.dart';
import 'package:work_hive_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:work_hive_mobile/features/user_data/presentation/view/job_seeker_view.dart';
import 'package:work_hive_mobile/features/user_data/presentation/view_model/bloc/job_seeker_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignupBloc _signupBloc;
  final JobSeekerBloc _jobSeekerBloc;
  final HomeCubit _homeCubit;

  final LoginUseCase _loginUseCase;

  LoginBloc({
    required SignupBloc signupBloc,
    required HomeCubit homeCubit,
    required JobSeekerBloc jobSeekerBloc,
    required LoginUseCase loginUseCase,
  })  : _signupBloc = signupBloc,
        _homeCubit = homeCubit,
        _jobSeekerBloc = jobSeekerBloc,
        _loginUseCase = loginUseCase,
        super(LoginState.initial()) {
    on<NavigateRegisterScreenEvent>(
      (event, emit) {
        Navigator.push(
          event.context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider.value(value: _signupBloc),
              ],
              child: event.destination,
            ),
          ),
        );
      },
    );

    on<NavigateHomeScreenEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _homeCubit,
              child: event.destination,
            ),
          ),
        );
      },
    );
    on<NavigateJobProfileEvent>(
      (event, emit) {
        Navigator.pushReplacement(
          event.context,
          MaterialPageRoute(
            builder: (context) => BlocProvider.value(
              value: _jobSeekerBloc,
              child: event.destination,
            ),
          ),
        );
      },
    );
    // Event handler for logging in
    // on<LoginUserEvent>(
    //   (event, emit) async {
    //     emit(state.copyWith(isLoading: true));
    //     final result = await _loginUseCase(
    //       LoginParams(
    //         email: event.email,
    //         password: event.password,
    //       ),
    //     );

    //     result.fold(
    //       (failure) {
    //         emit(state.copyWith(isLoading: false, isSuccess: false));
    //         // Show Snackbar for failure
    //         showMySnackBar(
    //           context: event.context,
    //           message: "Invalid Credentials",
    //           color: Colors.red,
    //         );
    //       },
    //       (token) {
    //         emit(state.copyWith(isLoading: false, isSuccess: true));

    //         showMySnackBar(
    //           context: event.context,
    //           message: "Login Successful",
    //           color: Colors.green,
    //         );

    //         add(NavigateHomeScreenEvent(
    //           context: event.context,
    //           destination: const JobSeekerView(),
    //         ));
    //       },
    //     );
    //   },
    // );
    on<LoginUserEvent>(
      (event, emit) async {
        emit(state.copyWith(isLoading: true));
        final result = await _loginUseCase(
          LoginParams(
            email: event.email,
            password: event.password,
          ),
        );

        result.fold(
          (failure) {
            emit(state.copyWith(isLoading: false, isSuccess: false));
            showMySnackBar(
              context: event.context,
              message: "Invalid Credentials",
              color: Colors.red,
            );
          },
          (loginResponse) {
            emit(state.copyWith(isLoading: false, isSuccess: true));
            showMySnackBar(
              context: event.context,
              message: "Login Successful",
              color: Colors.green,
            );
            if (loginResponse.role == 'User') {
              if (loginResponse.jobSeekerId != null) {
                add(NavigateHomeScreenEvent(
                  context: event.context,
                  destination: const HomeView(),
                ));
              } else {
                add(NavigateJobProfileEvent(
                  context: event.context,
                  destination: const JobSeekerView(),
                ));
              }
            } else if (loginResponse.role == 'Employer') {
              // Show coming soon message for employers
              showMySnackBar(
                context: event.context,
                message: "Employer Dashboard - Coming Soon!",
                color: Colors.blue,
              );

              // Optional: Clear loading state without navigation
              emit(state.copyWith(isLoading: false));
            }
          },
        );
      },
    );
  }
}

void showMySnackBar({
  required BuildContext context,
  required String message,
  required Color color,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: color,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
