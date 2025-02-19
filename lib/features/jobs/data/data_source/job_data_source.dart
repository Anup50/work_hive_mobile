import 'package:work_hive_mobile/features/jobs/domain/entity/job_entty.dart';

abstract interface class IJobDataSource {
  Future<List<JobEntity>> getJobs();

  Future<JobEntity> getJob(String id);

  Future<void> createJob(JobEntity job);

  Future<void> deleteJob(String id);
}
