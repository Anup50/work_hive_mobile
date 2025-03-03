import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/app/usecase/usecase.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/domain/repository/job_repository.dart';

class GetRecommendedParams extends Equatable {
  final String jobSeekerId;

  const GetRecommendedParams({required this.jobSeekerId});

  const GetRecommendedParams.empty() : jobSeekerId = '_empty.string';
  @override
  List<Object?> get props => [id];
}

class GetRecommendedUsecase
    implements UsecaseWithParams<List<JobEntity>, GetRecommendedParams> {
  final IJobRepository _jobRepository;

  GetRecommendedUsecase({required IJobRepository jobRepository})
      : _jobRepository = jobRepository;

  @override
  Future<Either<Failure, List<JobEntity>>> call(params) {
    return _jobRepository.getRecommended(params.jobSeekerId);
  }
}
