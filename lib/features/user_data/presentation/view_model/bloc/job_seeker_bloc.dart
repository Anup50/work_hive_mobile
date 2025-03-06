import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/app/shared_prefs/token_shared_prefs.dart';
import 'package:work_hive_mobile/core/common/components/snackbar.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/home/presentation/view/home_view.dart';
import 'package:work_hive_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/add_jobseeker_usecase.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/get_jobseeker_usecase.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/update_jobseeker_usecase.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/upload_profile_picture.dart';

part 'job_seeker_event.dart';
part 'job_seeker_state.dart';

class JobSeekerBloc extends Bloc<JobSeekerEvent, JobSeekerState> {
  final HomeCubit _homeCubit;
  final AddJobseekerUsecase _addJobseekerUsecase;
  final UploadImageUsecase _uploadImageUsecase;
  final GetJobseekerUsecase _getJobseekerUsecase;
  final UpdateJobseekerUsecase _updateJobseekerUsecase;
  final TokenSharedPrefs _tokenSharedPrefs;
  JobSeekerBloc({
    required AddJobseekerUsecase addJobseekerUsecase,
    required UploadImageUsecase uploadImageUsecase,
    required GetJobseekerUsecase getJobseekerUsecase,
    required UpdateJobseekerUsecase updateJobSeekerUsecase,
    required HomeCubit homeCubit,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _addJobseekerUsecase = addJobseekerUsecase,
        _uploadImageUsecase = uploadImageUsecase,
        _getJobseekerUsecase = getJobseekerUsecase,
        _updateJobseekerUsecase = updateJobSeekerUsecase,
        _homeCubit = homeCubit,
        _tokenSharedPrefs = tokenSharedPrefs,
        super(const JobSeekerState.initial()) {
    on<LoadJobSeekerProfileEvent>(_onLoadJobSeekerProfile);
    on<UploadImage>(_onLoadImage);
    on<AddJobSeeker>(_onAddJobseekerEvent);
    on<UpdateJobSeekerEvent>(_onUpdateJobSeeker);
    on<NavigateDashEvent>(
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
    _loadJobSeekerIdAndDispatchEvent();
  }
  Future<void> _loadJobSeekerIdAndDispatchEvent() async {
    final either = await _tokenSharedPrefs.getJobSeekerId();
    either.fold(
      (failure) {
        debugPrint('❌ Failed to get JobSeeker ID: ${failure.message}');
        // Handle missing ID (e.g., navigate to login)
        add(const LoadJobSeekerProfileEvent(id: '')); // Example fallback
      },
      (id) {
        if (id != null && id.isNotEmpty) {
          debugPrint('✅ Dispatched LoadJobSeekerProfileEvent with ID: $id');
          add(LoadJobSeekerProfileEvent(id: id));
        } else {
          debugPrint('❌ JobSeeker ID is null/empty');
        }
      },
    );
  }

  void _onAddJobseekerEvent(
    AddJobSeeker event,
    Emitter<JobSeekerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _addJobseekerUsecase.call(AddJobseekerParams(
      userId: event.userId,
      bio: event.bio,
      location: event.location,
      createdAt: event.createdAt,
      updatedAt: event.updatedAt,
      skills: event.skills,
      profilePicture: state.imageName,
    ));

    result.fold(
      (l) {
        emit(state.copyWith(isLoading: false, isSuccess: false));
        showMySnackBar(
            context: event.context, message: l.message, color: Colors.red);
      },
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true));
        showMySnackBar(context: event.context, message: "Saved Successfully");

        add(NavigateDashEvent(
          context: event.context,
          destination: const HomeView(),
        ));
      },
    );
  }

  void _onLoadImage(
    UploadImage event,
    Emitter<JobSeekerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _uploadImageUsecase.call(
      UploadImageParams(
        file: event.file,
      ),
    );

    result.fold(
      (l) => emit(state.copyWith(isLoading: false, isSuccess: false)),
      (r) {
        emit(state.copyWith(isLoading: false, isSuccess: true, imageName: r));
      },
    );
  }

  // Future<void> _onLoadJobSeekerProfile(
  //   LoadJobSeekerProfileEvent event,
  //   Emitter<JobSeekerState> emit,
  // ) async {
  //   emit(state.copyWith(isLoading: true, errorMessage: null));
  //   final result = await _getJobseekerUsecase(GetJobSeekerParams(id: event.id));

  //   result.fold(
  //     (failure) =>
  //         emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
  //     (jobSeeker) {
  //       emit(state.copyWith(
  //           isLoading: false, jobSeeker: jobSeeker, errorMessage: ''));
  //     },
  //   );
  // }
  Future<void> _onLoadJobSeekerProfile(
    LoadJobSeekerProfileEvent event,
    Emitter<JobSeekerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    debugPrint('📡 Fetching JobSeeker Profile for ID: ${event.id}');

    final result = await _getJobseekerUsecase(GetJobSeekerParams(id: event.id));
    result.fold(
      (failure) {
        debugPrint('❌ Failure: ${failure.message}');
        emit(state.copyWith(isLoading: false, errorMessage: failure.message));
      },
      (jobSeeker) {
        debugPrint('✅ Loaded JobSeeker: ${jobSeeker.toString()}');
        emit(state.copyWith(
          isLoading: false,
          jobSeeker: jobSeeker,
          errorMessage: null,
        ));
      },
    );
  }

  Future<void> _onUpdateJobSeeker(
    UpdateJobSeekerEvent event,
    Emitter<JobSeekerState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await _updateJobseekerUsecase(UpdateJobSeekerParams(
      id: event.id,
      jobSeeker: event.jobSeeker,
    ));

    result.fold(
      (failure) => emit(state.copyWith(
          isLoading: false, errorMessage: _mapFailureToMessage(failure))),
      (_) {
        // Corrected: Added curly braces to create a block
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
        ));
        add(LoadJobSeekerProfileEvent(id: event.id));
      }, // Corrected: Closing curly brace for the fold function
    );
  }
  // Future<void> _onUpdateJobSeeker(
  //   UpdateJobSeekerEvent event,
  //   Emitter<JobSeekerState> emit,
  // ) async {
  //   emit(state.copyWith(isLoading: true, errorMessage: null));

  //   final result = await _updateJobseekerUsecase(UpdateJobSeekerParams(
  //     id: event.id,
  //     jobSeeker: event.jobSeeker,
  //   ));

  //   result.fold(
  //     (failure) => emit(state.copyWith(
  //         isLoading: false, errorMessage: _mapFailureToMessage(failure))),
  //     (_) => emit(state.copyWith(
  //       isLoading: false,
  //       isSuccess: true,
  //     )
  //     add(LoadJobSeekerProfileEvent(id: event.id));
  //     ),
  //   );
  // }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return 'Server Failure';
      case const (NetworkFailure):
        return 'Network Failure';
      default:
        return 'Unexpected Error';
    }
  }
}
