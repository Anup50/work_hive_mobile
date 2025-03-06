import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/app/usecase/usecase.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';
import 'package:work_hive_mobile/features/user_data/domain/repository/job_seeker_repository.dart';

// Params class to pass required parameters
class UpdateJobSeekerParams extends Equatable {
  final String id;
  final JobSeekerEntity jobSeeker;

  const UpdateJobSeekerParams({
    required this.id,
    required this.jobSeeker,
  });

  @override
  List<Object?> get props => [id, jobSeeker];
}

class UpdateJobseekerUsecase
    implements UsecaseWithParams<void, UpdateJobSeekerParams> {
  final IJobSeekerRepository repository;

  UpdateJobseekerUsecase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateJobSeekerParams params) async {
    return await repository.updateUserData(params.id, params.jobSeeker);
  }
}
