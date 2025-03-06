import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:work_hive_mobile/app/usecase/usecase.dart';
import 'package:work_hive_mobile/core/error/failure.dart';
import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';
import 'package:work_hive_mobile/features/user_data/domain/repository/job_seeker_repository.dart';

class AddJobseekerParams extends Equatable {
  final String? userId;
  final String? profilePicture;
  final String? bio;
  final String? location;
  final List<String> skills;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AddJobseekerParams({
    this.userId,
    this.profilePicture,
    this.bio,
    this.location,
    this.skills = const [],
    this.createdAt,
    this.updatedAt,
  });

  //Initial Const
  const AddJobseekerParams.initial({
    this.userId,
    this.profilePicture,
    this.bio,
    this.location,
    this.skills = const [],
    this.createdAt,
    this.updatedAt,
  });
  @override
  List<Object?> get props =>
      [userId, profilePicture, bio, location, skills, createdAt, updatedAt];
}

class AddJobseekerUsecase
    implements UsecaseWithParams<void, AddJobseekerParams> {
  final IJobSeekerRepository repository;
  AddJobseekerUsecase(this.repository);
  @override
  Future<Either<Failure, void>> call(AddJobseekerParams params) {
    final jobseekerEntity = JobSeekerEntity(
      bio: params.bio,
      skills: params.skills,
      profilePicture: params.profilePicture,
      location: params.location,
      userId: params.userId,
    );
    return repository.addJobSeekerData(jobseekerEntity);
  }
}
