import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_all_jobs_usecase.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_job_by_id_usecase.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/get_recommended_usecase.dart';

part 'job_event.dart';
part 'job_state.dart';

class JobBloc extends Bloc<JobEvent, JobState> {
  final GetAllJobsUsecase _getAllJobsUsecase;
  final GetJobByIdUsecase _getJobByIdUsecase;
  final GetRecommendedUsecase _getRecommendedUsecase;
  JobBloc({
    required GetAllJobsUsecase getAllJobsUsecase,
    required GetJobByIdUsecase getJobByIdUsecase,
    required GetRecommendedUsecase getRecommendedUsecase,
  })  : _getAllJobsUsecase = getAllJobsUsecase,
        _getJobByIdUsecase = getJobByIdUsecase,
        _getRecommendedUsecase = getRecommendedUsecase,
        super(JobState.initial()) {
    on<LoadJobs>(_onJobsLoad);
    on<GetRecommended>(_onRecommendedLoad);

    on<GetJob>(_onLoadJob);
    add(LoadJobs());
    add(const GetRecommended(jobSeekerId: "67c38126d4b3df336fb61b6a"));
  }
  Future<void> _onJobsLoad(
    LoadJobs event,
    Emitter<JobState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAllJobsUsecase();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (jobs) {
        if (jobs.isEmpty) {
          // Check for empty list HERE!
          emit(state.copyWith(
              isLoading: false,
              jobs: [],
              error: 'No jobs found.')); // Handle empty list
        } else {
          emit(state.copyWith(isLoading: false, jobs: jobs));
        }
      },
    );
  }

  Future<void> _onRecommendedLoad(
    GetRecommended event,
    Emitter<JobState> emit,
  ) async {
    emit(state.copyWith(isLoadingRecommended: true));
    final result = await _getRecommendedUsecase(
        GetRecommendedParams(jobSeekerId: event.jobSeekerId));

    result.fold(
      (failure) => emit(
          state.copyWith(isLoadingRecommended: false, error: failure.message)),
      (recommendedJobs) {
        if (recommendedJobs.isEmpty) {
          emit(state.copyWith(
              isLoadingRecommended: false,
              recommendedJobs: [],
              recommendedError: 'No jobs found.')); // Handle empty list
        } else {
          emit(state.copyWith(
              isLoadingRecommended: false, recommendedJobs: recommendedJobs));
        }
      },
    );
  }

  Future<void> _onLoadJob(
    GetJob event,
    Emitter<JobState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final result = await _getJobByIdUsecase(GetJobByIdParams(id: event.id));
    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (_) {
        emit(state.copyWith(isLoading: false));
      },
    );
  }
}
