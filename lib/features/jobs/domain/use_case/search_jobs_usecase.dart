import 'package:dartz/dartz.dart';
import 'package:work_hive_mobile/app/usecase/usecase.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/repository/job_repository.dart';

class SearchJobsUseCase implements UsecaseWithParams<List<JobEntity>, String> {
  final IJobRepository jobRepository;

  SearchJobsUseCase(this.jobRepository);

  @override
  Future<Either<Failure, List<JobEntity>>> call(String query) async {
    print('SearchJobsUseCase called with query: $query');
    return await jobRepository.searchJobs(query);
  }
}
