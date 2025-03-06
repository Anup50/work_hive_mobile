// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:work_hive_mobile/app/di/di.dart';
// import 'package:work_hive_mobile/core/common/components/job_card.dart';
// import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';
// import 'package:work_hive_mobile/features/jobs/presentation/view_model/search/searchjobs_bloc.dart';

// class DashboardView extends StatefulWidget {
//   const DashboardView({super.key});

//   @override
//   State<DashboardView> createState() => _DashboardViewState();
// }

// class _DashboardViewState extends State<DashboardView> {
//   bool _isSearching = false;
//   String _searchQuery = "";

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<SearchjobsBloc>(
//       create: (context) => getIt<SearchjobsBloc>(),
//       child: Scaffold(
//         appBar: AppBar(
//           toolbarHeight: 0,
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//         ),
//         // Using ListView as the main scrollable container to avoid nested scroll views.
//         body: ListView(
//           padding: const EdgeInsets.all(12.0),
//           children: [
//             const Text(
//               "Welcome, Back",
//               style: TextStyle(
//                 fontSize: 24,
//                 fontFamily: 'PlusJakartaSans SemiBold',
//               ),
//             ),
//             const SizedBox(height: 10),
//             TextField(
//               onChanged: (query) {
//                 print("User typed: $query");
//                 if (query.isNotEmpty) {
//                   _searchQuery = query;
//                   _isSearching = true;
//                   // Dispatch search event
//                   context
//                       .read<SearchjobsBloc>()
//                       .add(SearchjobsQueryEvent(query));
//                 } else {
//                   _isSearching = false;
//                 }
//                 setState(() {});
//               },
//               decoration: InputDecoration(
//                 prefixIcon: const Icon(Icons.search),
//                 hintText: "Search Here",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(25),
//                   borderSide: BorderSide(color: Colors.grey[400]!),
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             SizedBox(
//               height: 50,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 children: const [
//                   CategoryChip(label: "UI/UX"),
//                   CategoryChip(label: "Graphics Design"),
//                   CategoryChip(label: "React"),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 8),
//             // Show search results if _isSearching is true
//             _isSearching
//                 ? SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.6,
//                     child: BlocBuilder<SearchjobsBloc, SearchjobsState>(
//                       builder: (context, state) {
//                         if (state is SearchJobsLoading) {
//                           return const Center(
//                               child: CircularProgressIndicator());
//                         }
//                         if (state is SearchJobsError) {
//                           return Center(child: Text(state.message));
//                         }
//                         if (state is SearchJobsLoaded) {
//                           return state.jobs.isEmpty
//                               ? const Center(child: Text('No jobs found'))
//                               : ListView.builder(
//                                   itemCount: state.jobs.length,
//                                   itemBuilder: (context, index) {
//                                     final job = state.jobs[index];
//                                     return JobCard(
//                                       key: ValueKey(job.jobId),
//                                       jobTitle: job.title,
//                                       companyName: job.employer.companyName ??
//                                           'Unknown Company',
//                                       jobLocation: job.location,
//                                       imagePath: job.employer.companyLogo ?? '',
//                                     );
//                                   },
//                                 );
//                         }
//                         return const Center(
//                             child: Text('Start typing to search jobs'));
//                       },
//                     ),
//                   )
//                 : Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         "Recommended for you",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       BlocBuilder<JobBloc, JobState>(
//                         builder: (context, state) {
//                           if (state.isLoadingRecommended) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           } else if (state.error.isNotEmpty) {
//                             return Center(child: Text("Error: ${state.error}"));
//                           } else if (state.recommendedJobs.isEmpty) {
//                             return const Center(
//                                 child: Text('No recommended Jobs'));
//                           } else {
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: state.recommendedJobs.length,
//                               itemBuilder: (context, index) {
//                                 final recommendedJob =
//                                     state.recommendedJobs[index];
//                                 return JobCard(
//                                   key: ValueKey(recommendedJob.jobId),
//                                   jobTitle: recommendedJob.title,
//                                   companyName:
//                                       recommendedJob.employer.companyName,
//                                   jobLocation: recommendedJob.location,
//                                   imagePath:
//                                       recommendedJob.employer.companyLogo,
//                                 );
//                               },
//                             );
//                           }
//                         },
//                       ),
//                       Center(
//                         child: TextButton(
//                           onPressed: () {},
//                           child: const Text("See all"),
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       const Text(
//                         "Recent Postings",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       BlocBuilder<JobBloc, JobState>(
//                         builder: (context, state) {
//                           if (state.isLoading) {
//                             return const Center(
//                                 child: CircularProgressIndicator());
//                           } else if (state.error.isNotEmpty) {
//                             return Center(child: Text("Error: ${state.error}"));
//                           } else if (state.jobs.isEmpty) {
//                             return const Center(
//                                 child: Text('No recent job postings'));
//                           } else {
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               physics: const NeverScrollableScrollPhysics(),
//                               itemCount: state.jobs.length,
//                               itemBuilder: (context, index) {
//                                 final job = state.jobs[index];
//                                 return JobCard(
//                                   key: ValueKey(job.jobId),
//                                   jobTitle: job.title,
//                                   companyName: job.employer.companyName,
//                                   jobLocation: job.location,
//                                   imagePath: job.employer.companyLogo,
//                                 );
//                               },
//                             );
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class CategoryChip extends StatelessWidget {
//   final String label;
//   const CategoryChip({super.key, required this.label});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 8.0),
//       child: Chip(
//         label: Text(label),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/app/di/di.dart';
import 'package:work_hive_mobile/core/common/components/job_card.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/search/searchjobs_bloc.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _isSearching = false;
  String _searchQuery = "";
  Future<void> _refreshJobs(BuildContext context) async {
    // Refresh recommended and recent jobs
    context.read<JobBloc>().add(LoadJobs());

    // Refresh recommended jobs with the current jobSeekerId
    final jobSeekerIdResult =
        await context.read<JobBloc>().tokenSharedPrefs.getJobSeekerId();
    jobSeekerIdResult.fold(
      (failure) {
        print("Error getting jobSeekerId: ${failure.message}");
      },
      (jobSeekerId) {
        if (jobSeekerId != null) {
          context.read<JobBloc>().add(GetRecommended(jobSeekerId: jobSeekerId));
        } else {
          print("jobSeekerId is null");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchjobsBloc>(
      create: (context) => getIt<SearchjobsBloc>(),
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: RefreshIndicator(
          onRefresh: () => _refreshJobs(context),
          child: ListView(
            padding: const EdgeInsets.all(12.0),
            children: [
              // ... (your existing UI code)
              const Text(
                "Welcome, Back",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'PlusJakartaSans SemiBold',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                onChanged: (query) {
                  print("User typed: $query");
                  if (query.isNotEmpty) {
                    _searchQuery = query;
                    _isSearching = true;
                    // Dispatch search event
                    context
                        .read<SearchjobsBloc>()
                        .add(SearchjobsQueryEvent(query));
                  } else {
                    _isSearching = false;
                  }
                  setState(() {});
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search Here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryChip(label: "UI/UX"),
                    CategoryChip(label: "Graphics Design"),
                    CategoryChip(label: "React"),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Show search results if _isSearching is true
              _isSearching
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: BlocBuilder<SearchjobsBloc, SearchjobsState>(
                        builder: (context, state) {
                          if (state is SearchJobsLoading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (state is SearchJobsError) {
                            return Center(child: Text(state.message));
                          }
                          if (state is SearchJobsLoaded) {
                            return state.jobs.isEmpty
                                ? const Center(child: Text('No jobs found'))
                                : ListView.builder(
                                    itemCount: state.jobs.length,
                                    itemBuilder: (context, index) {
                                      final job = state.jobs[index];
                                      return JobCard(
                                        key: ValueKey(job.jobId),
                                        jobTitle: job.title,
                                        companyName: job.employer.companyName ??
                                            'Unknown Company',
                                        jobLocation: job.location,
                                        imagePath:
                                            job.employer.companyLogo ?? '',
                                      );
                                    },
                                  );
                          }
                          return const Center(
                              child: Text('Start typing to search jobs'));
                        },
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ... (your recommended and recent jobs code)
                        const Text(
                          "Recommended for you",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<JobBloc, JobState>(
                          builder: (context, state) {
                            if (state.isLoadingRecommended) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state.error.isNotEmpty) {
                              return Center(
                                  child: Text("Error: ${state.error}"));
                            } else if (state.recommendedJobs.isEmpty) {
                              return const Center(
                                  child: Text('No recommended Jobs'));
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.recommendedJobs.length,
                                itemBuilder: (context, index) {
                                  final recommendedJob =
                                      state.recommendedJobs[index];
                                  return JobCard(
                                    key: ValueKey(recommendedJob.jobId),
                                    jobTitle: recommendedJob.title,
                                    companyName:
                                        recommendedJob.employer.companyName,
                                    jobLocation: recommendedJob.location,
                                    imagePath:
                                        recommendedJob.employer.companyLogo,
                                  );
                                },
                              );
                            }
                          },
                        ),
                        Center(
                          child: TextButton(
                            onPressed: () {},
                            child: const Text("See all"),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Recent Postings",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        BlocBuilder<JobBloc, JobState>(
                          builder: (context, state) {
                            if (state.isLoading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state.error.isNotEmpty) {
                              return Center(
                                  child: Text("Error: ${state.error}"));
                            } else if (state.jobs.isEmpty) {
                              return const Center(
                                  child: Text('No recent job postings'));
                            } else {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: state.jobs.length,
                                itemBuilder: (context, index) {
                                  final job = state.jobs[index];
                                  return JobCard(
                                    key: ValueKey(job.jobId),
                                    jobTitle: job.title,
                                    companyName: job.employer.companyName,
                                    jobLocation: job.location,
                                    imagePath: job.employer.companyLogo,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

// ... (CategoryChip widget)

class CategoryChip extends StatelessWidget {
  final String label;
  const CategoryChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
      ),
    );
  }
}
