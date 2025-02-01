import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:work_hive_mobile/core/common/components/snackbar.dart';
import 'package:work_hive_mobile/features/auth/domain/use_case/register_use_case.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final RegisterUseCase _registerUseCase;

  SignupBloc({
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        super(SignupState.initial()) {
    //load jobs here
    on<RegisterUser>(_onRegisterEvent);

    // add(LoadCoursesAndBatches());
  }

  // void _onLoadCoursesAndBatches(
  //   LoadCoursesAndBatches event,
  //   Emitter<RegisterState> emit,
  // ) {
  //   emit(state.copyWith(isLoading: true));
  //   _batchBloc.add(LoadBatches());
  //   _courseBloc.add(CourseLoad());
  //   emit(state.copyWith(isLoading: false, isSuccess: true));
  // }

  void _onRegisterEvent(
    RegisterUser event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _registerUseCase.call(RegisterUserParams(
      name: event.name,
      email: event.email,
      role: event.role,
      password: event.password,
    ));

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(
            context: event.context, message: "Registration Successful");
      },
    );
  }
}
