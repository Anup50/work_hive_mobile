import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/core/common/components/snackbar.dart';
import 'package:work_hive_mobile/features/home/presentation/view/home_view.dart';
import 'package:work_hive_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/add_jobseeker_usecase.dart';
import 'package:work_hive_mobile/features/user_data/domain/use_case/upload_profile_picture.dart';

part 'job_seeker_event.dart';
part 'job_seeker_state.dart';

class JobSeekerBloc extends Bloc<JobSeekerEvent, JobSeekerState> {
  final HomeCubit _homeCubit;
  final AddJobseekerUsecase _addJobseekerUsecase;
  final UploadImageUsecase _uploadImageUsecase;

  JobSeekerBloc({
    required AddJobseekerUsecase addJobseekerUsecase,
    required UploadImageUsecase uploadImageUsecase,
    required HomeCubit homeCubit,
  })  : _addJobseekerUsecase = addJobseekerUsecase,
        _uploadImageUsecase = uploadImageUsecase,
        _homeCubit = homeCubit,
        super(const JobSeekerState.initial()) {
    on<UploadImage>(_onLoadImage);
    on<AddJobSeeker>(_onAddJobseekerEvent);
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
}
