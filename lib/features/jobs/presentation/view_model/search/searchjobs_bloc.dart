// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
// import 'package:work_hive_mobile/features/jobs/domain/use_case/search_jobs_usecase.dart';

// part 'searchjobs_event.dart';
// part 'searchjobs_state.dart';

// class SearchjobsBloc extends Bloc<SearchjobsEvent, SearchjobsState> {
//   final SearchJobsUseCase _searchJobsUseCase;
//   final List<JobEntity> _jobs = [];

//   SearchjobsBloc({required SearchJobsUseCase searchJobsUseCase})
//       : _searchJobsUseCase = searchJobsUseCase,
//         super(SearchjobsInitial()) {
//     on<SearchjobsQueryEvent>(_onSearchjobsQuery);
//   }

//   Future<void> _onSearchjobsQuery(
//     SearchjobsQueryEvent event,
//     Emitter<SearchjobsState> emit,
//   ) async {
//     _jobs.clear();
//     emit(SearchJobsLoading());
//     final result = await _searchJobsUseCase(event.query);
//     result.fold(
//       (failure) => emit(SearchJobsError(failure.message)),
//       (newJobs) {
//         _jobs.addAll(newJobs);
//         emit(SearchJobsLoaded(_jobs));
//       },
//     );
//   }
// }
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/use_case/search_jobs_usecase.dart';

part 'searchjobs_event.dart';
part 'searchjobs_state.dart';

class SearchjobsBloc extends Bloc<SearchjobsEvent, SearchjobsState> {
  final SearchJobsUseCase _searchJobsUseCase;
  final List<JobEntity> _jobs = [];

  SearchjobsBloc({required SearchJobsUseCase searchJobsUseCase})
      : _searchJobsUseCase = searchJobsUseCase,
        super(SearchjobsInitial()) {
    on<SearchjobsQueryEvent>(_onSearchjobsQuery);
  }

  Future<void> _onSearchjobsQuery(
    SearchjobsQueryEvent event,
    Emitter<SearchjobsState> emit,
  ) async {
    print("BLoC received query event: ${event.query}");
    try {
      if (event.query.isEmpty) {
        emit(SearchjobsInitial()); // Reset to initial state
        return;
      }

      emit(SearchJobsLoading());

      final result = await _searchJobsUseCase(event.query);

      result.fold(
        (failure) => emit(SearchJobsError(failure.message)),
        (newJobs) => emit(SearchJobsLoaded(List.from(newJobs))),
      );
    } catch (e) {
      emit(SearchJobsError('Search failed: ${e.toString()}'));
    }
  }
}
