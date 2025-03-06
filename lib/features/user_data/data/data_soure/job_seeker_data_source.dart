import 'dart:io';

import 'package:work_hive_mobile/features/user_data/domain/entity/job_seeker_entity.dart';

abstract interface class IJobSeekerDataSource {
  Future<void> addJobSeekerData(JobSeekerEntity jobseeker);
  Future<void> updateUserData(String id, JobSeekerEntity jobseeker);

  Future<JobSeekerEntity> getUserData(String id);
  Future<String> uploadProfilePicture(File file);
}
