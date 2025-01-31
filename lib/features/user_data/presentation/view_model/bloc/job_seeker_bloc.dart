import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:work_hive_mobile/core/common/components/snackbar.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/add_jobseeker_usecase.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/upload_profile_picture.dart';

part 'job_seeker_event.dart';
part 'job_seeker_state.dart';

class JobSeekerBloc extends Bloc<JobSeekerEvent, JobSeekerState> {
  final AddJobseekerUsecase _addJobseekerUsecase;
  final UploadImageUsecase _uploadImageUsecase;

  JobSeekerBloc({
    required AddJobseekerUsecase addJobseekerUsecase,
    required UploadImageUsecase uploadImageUsecase,
  })  : _addJobseekerUsecase = addJobseekerUsecase,
        _uploadImageUsecase = uploadImageUsecase,
        super(const JobSeekerState.initial()) {
    on<UploadImage>(_onLoadImage);
    on<AddJobSeeker>(_onAddJobseekerEvent);
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
        showMySnackBar(
            context: event.context, message: "Registration Successful");
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
}
