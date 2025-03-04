import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/app/shared_prefs/token_shared_prefs.dart';
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

  final TokenSharedPrefs _tokenSharedPrefs;

  JobBloc({
    required GetAllJobsUsecase getAllJobsUsecase,
    required GetJobByIdUsecase getJobByIdUsecase,
    required GetRecommendedUsecase getRecommendedUsecase,
    required TokenSharedPrefs tokenSharedPrefs,
  })  : _getAllJobsUsecase = getAllJobsUsecase,
        _getJobByIdUsecase = getJobByIdUsecase,
        _getRecommendedUsecase = getRecommendedUsecase,
        _tokenSharedPrefs = tokenSharedPrefs,
        super(JobState.initial()) {
    on<LoadJobs>(_onJobsLoad);

    on<GetRecommended>(_onRecommendedLoad);

    on<GetJob>(_onLoadJob);

    add(LoadJobs());

    _initRecommendedJobs();
  }

  Future<void> _initRecommendedJobs() async {
    final result = await _tokenSharedPrefs.getJobSeekerId();

    result.fold(
      (failure) {
        print("Error getting jobSeekerId: ${failure.message}");
      },
      (jobSeekerId) {
        if (jobSeekerId != null) {
          add(GetRecommended(jobSeekerId: jobSeekerId));
        } else {
          print("jobSeekerId is null");
        }
      },
    );
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
              recommendedError: 'No jobs found.'));
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
      (job) {
        emit(state.copyWith(isLoading: false, job: job, jobError: ''));
      },
    );
  }
}




// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:work_hive_mobile/app/shared_prefs/token_shared_prefs.dart';
// import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
// import 'package:work_hive_mobile/features/jobs/domain/use_case/get_all_jobs_usecase.dart';
// import 'package:work_hive_mobile/features/jobs/domain/use_case/get_job_by_id_usecase.dart';
// import 'package:work_hive_mobile/features/jobs/domain/use_case/get_recommended_usecase.dart';

// part 'job_event.dart';
// part 'job_state.dart';

// class JobBloc extends Bloc<JobEvent, JobState> {
//   final GetAllJobsUsecase _getAllJobsUsecase;
//   final GetJobByIdUsecase _getJobByIdUsecase;
//   final GetRecommendedUsecase _getRecommendedUsecase;
//   final TokenSharedPrefs _tokenSharedPrefs;
//   JobBloc({
//     required GetAllJobsUsecase getAllJobsUsecase,
//     required GetJobByIdUsecase getJobByIdUsecase,
//     required GetRecommendedUsecase getRecommendedUsecase,
//     required TokenSharedPrefs tokenSharedPrefs,
//   })  : _getAllJobsUsecase = getAllJobsUsecase,
//         _getJobByIdUsecase = getJobByIdUsecase,
//         _getRecommendedUsecase = getRecommendedUsecase,
//         _tokenSharedPrefs = tokenSharedPrefs,
//         super(JobState.initial()) {
//     on<LoadJobs>(_onJobsLoad);
//     on<GetRecommended>(_onRecommendedLoad);

//     on<GetJob>(_onLoadJob);
//     add(LoadJobs());
//     _initRecommendedJobs();
//   }
//   Future<void> _initRecommendedJobs() async {
//     final result = await _tokenSharedPrefs.getJobSeekerId();
//     result.fold(
//       (failure) {
//         // Handle failure scenario, e.g., log error or emit an error state
//         print("Error getting jobSeekerId: ${failure.message}");
//       },
//       (jobSeekerId) {
//         if (jobSeekerId != null) {
//           add(GetRecommended(jobSeekerId: jobSeekerId));
//         } else {
//           print("jobSeekerId is null");
//         }
//       },
//     );
//   }

//   Future<void> _onJobsLoad(
//     LoadJobs event,
//     Emitter<JobState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await _getAllJobsUsecase();

//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (jobs) {
//         if (jobs.isEmpty) {
//           // Check for empty list HERE!
//           emit(state.copyWith(
//               isLoading: false,
//               jobs: [],
//               error: 'No jobs found.')); // Handle empty list
//         } else {
//           emit(state.copyWith(isLoading: false, jobs: jobs));
//         }
//       },
//     );
//   }

//   Future<void> _onRecommendedLoad(
//     GetRecommended event,
//     Emitter<JobState> emit,
//   ) async {
//     emit(state.copyWith(isLoadingRecommended: true));
//     final result = await _getRecommendedUsecase(
//         GetRecommendedParams(jobSeekerId: event.jobSeekerId));

//     result.fold(
//       (failure) => emit(
//           state.copyWith(isLoadingRecommended: false, error: failure.message)),
//       (recommendedJobs) {
//         if (recommendedJobs.isEmpty) {
//           emit(state.copyWith(
//               isLoadingRecommended: false,
//               recommendedJobs: [],
//               recommendedError: 'No jobs found.'));
//         } else {
//           emit(state.copyWith(
//               isLoadingRecommended: false, recommendedJobs: recommendedJobs));
//         }
//       },
//     );
//   }

//   Future<void> _onLoadJob(
//     GetJob event,
//     Emitter<JobState> emit,
//   ) async {
//     emit(state.copyWith(isLoading: true));
//     final result = await _getJobByIdUsecase(GetJobByIdParams(id: event.id));
//     result.fold(
//       (failure) =>
//           emit(state.copyWith(isLoading: false, error: failure.message)),
//       (_) {
//         emit(state.copyWith(isLoading: false));
//       },
//     );
//   }
// }