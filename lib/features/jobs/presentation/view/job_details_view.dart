// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
// import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';

// class JobDetailsPage extends StatefulWidget {
//   final String jobId;

//   const JobDetailsPage({super.key, required this.jobId});

//   @override
//   State<JobDetailsPage> createState() => _JobDetailsPageState();
// }

// class _JobDetailsPageState extends State<JobDetailsPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<JobBloc>().add(GetJob(id: widget.jobId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Job Details'),
//       ),
//       body: MultiBlocListener(
//         listeners: [
//           BlocListener<JobBloc, JobState>(
//             listener: (context, state) {
//               if (state is Error) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(state.error)),
//                 );
//               }
//             },
//           ),
//         ],
//         child: BlocBuilder<JobBloc, JobState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state.job != null) {
//               return _JobDetailsContent(job: state.job!);
//             }

//             if (state.error.isNotEmpty) {
//               return Center(child: Text('Error: ${state.error}'));
//             }

//             return const Center(child: Text('No job details found'));
//           },
//         ),
//       ),
//       // bottomNavigationBar: JobActionsWidget(jobId: widget.jobId),
//     );
//   }
// }

// class _JobDetailsContent extends StatelessWidget {
//   final JobEntity job;

//   const _JobDetailsContent({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _HeaderSection(job: job),
//           const SizedBox(height: 24),
//           _JobMetaSection(job: job),
//           const SizedBox(height: 24),
//           _SkillsSection(skills: job.skillsRequired),
//           const SizedBox(height: 24),
//           _DescriptionSection(
//             description: job.description.summary,
//           ),
//           const SizedBox(height: 24),
//           _ResponsibilitiesSection(
//               responsibilities: job.description.responsibilities.join('\n'))
//         ],
//       ),
//     );
//   }
// }

// class _HeaderSection extends StatelessWidget {
//   final JobEntity job;

//   const _HeaderSection({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 job.title,
//                 style: const TextStyle(
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 job.employer.companyName,
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 8),
//               Row(
//                 children: [
//                   const Icon(Icons.location_on_outlined, size: 18),
//                   const SizedBox(width: 4),
//                   Text(job.location),
//                   const SizedBox(width: 16),
//                   const Icon(Icons.access_time_outlined, size: 18),
//                   const SizedBox(width: 4),
//                   Text(job.jobType),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         _CompanyLogo(logoUrl: job.employer.companyLogo),
//       ],
//     );
//   }
// }

// class _CompanyLogo extends StatelessWidget {
//   final String? logoUrl;

//   const _CompanyLogo({this.logoUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 64,
//       height: 64,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         image: logoUrl != null
//             ? DecorationImage(
//                 image: NetworkImage(logoUrl!),
//                 fit: BoxFit.cover,
//               )
//             : null,
//         color: logoUrl == null ? Colors.grey[200] : null,
//       ),
//       child: logoUrl == null ? const Icon(Icons.business, size: 32) : null,
//     );
//   }
// }

// class _JobMetaSection extends StatelessWidget {
//   final JobEntity job;

//   const _JobMetaSection({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _MetaItem(
//           icon: Icons.work_outline,
//           title: 'Experience Level',
//           value: job.experienceLevel,
//         ),
//         const SizedBox(height: 12),
//         _MetaItem(
//           icon: Icons.attach_money,
//           title: 'Salary',
//           value: job.salary > 0
//               ? '\$${job.salary.toStringAsFixed(0)}/year'
//               : 'Not specified',
//         ),
//         const SizedBox(height: 12),
//         _MetaItem(
//           icon: Icons.calendar_today,
//           title: 'Posted',
//           value: job.datePosted != null
//               ? '${DateTime.now().difference(job.datePosted!).inDays} days ago'
//               : 'N/A',
//         ),
//       ],
//     );
//   }
// }

// class _MetaItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String value;

//   const _MetaItem({
//     required this.icon,
//     required this.title,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 20, color: Colors.grey),
//         const SizedBox(width: 12),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class _SkillsSection extends StatelessWidget {
//   final List<String> skills;

//   const _SkillsSection({required this.skills});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Required Skills',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: skills
//               .map((skill) => Chip(
//                     label: Text(skill),
//                     backgroundColor: Colors.blue[50],
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// // class _DescriptionSection extends StatelessWidget {
// //   final String description;

// //   const _DescriptionSection({required this.description});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const Text(
// //           'Job Description',
// //           style: TextStyle(
// //             fontSize: 18,
// //             fontWeight: FontWeight.bold,
// //           ),
// //         ),
// //         const SizedBox(height: 12),
// //         Text(
// //           description,
// //           style: const TextStyle(
// //             fontSize: 16,
// //             height: 1.5,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
// class _DescriptionSection extends StatelessWidget {
//   final String description;

//   const _DescriptionSection({required this.description});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Job Description',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           description,
//           style: const TextStyle(
//             fontSize: 16,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _ResponsibilitiesSection extends StatelessWidget {
//   final String responsibilities;

//   const _ResponsibilitiesSection({required this.responsibilities});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Responsibilities',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text(
//           responsibilities,
//           style: const TextStyle(
//             fontSize: 16,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
// }

// // import 'package:flutter/material.dart';

// // class JobDetailsPage extends StatelessWidget {
// //   final String jobId;

// //   const JobDetailsPage({super.key, required this.jobId});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('Job Details'),
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Text(
// //               'Job ID: $jobId',
// //               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 16),
// //             const Text(
// //               'Job Title: Placeholder Title',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             const SizedBox(height: 8),
// //             const Text(
// //               'Company: Placeholder Company',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             const SizedBox(height: 8),
// //             const Text(
// //               'Location: Placeholder Location',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             const SizedBox(height: 16),
// //             const Text(
// //               'Description:',
// //               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
// //             ),
// //             const SizedBox(height: 8),
// //             const Text(
// //               'Placeholder job description. This is where the job details will go.',
// //               style: TextStyle(fontSize: 16),
// //             ),
// //             // Add more placeholders as needed
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
// import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';

// class JobDetailsPage extends StatefulWidget {
//   final String jobId;

//   const JobDetailsPage({super.key, required this.jobId});

//   @override
//   State<JobDetailsPage> createState() => _JobDetailsPageState();
// }

// class _JobDetailsPageState extends State<JobDetailsPage> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<JobBloc>().add(GetJob(id: widget.jobId));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Application Report'),
//       ),
//       body: MultiBlocListener(
//         listeners: [
//           BlocListener<JobBloc, JobState>(
//             listener: (context, state) {
//               if (state is Error) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text(state.error)),
//                 );
//               }
//             },
//           ),
//         ],
//         child: BlocBuilder<JobBloc, JobState>(
//           builder: (context, state) {
//             if (state.isLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }

//             if (state.job != null) {
//               return _JobDetailsContent(job: state.job!);
//             }

//             if (state.error.isNotEmpty) {
//               return Center(child: Text('Error: ${state.error}'));
//             }

//             return const Center(child: Text('No job details found'));
//           },
//         ),
//       ),
//     );
//   }
// }

// class _JobDetailsContent extends StatelessWidget {
//   final JobEntity job;

//   const _JobDetailsContent({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _JobHeader(job: job),
//           const SizedBox(height: 24),
//           _JobDescription(job: job),
//           const SizedBox(height: 24),
//           _JobResponsibilities(job: job),
//           const SizedBox(height: 24),
//           _JobSkills(skills: job.skillsRequired),
//           const SizedBox(height: 24),
//           _JobMeta(job: job),
//           const SizedBox(height: 24),
//           // Placeholder for Save and Bookmark buttons
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               Container(
//                 width: 120,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Center(child: Text('Save')),
//               ),
//               Container(
//                 width: 120,
//                 height: 48,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Center(child: Text('Pending')),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _JobHeader extends StatelessWidget {
//   final JobEntity job;

//   const _JobHeader({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 job.title,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 job.employer.companyName,
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.grey[600],
//                 ),
//               ),
//               const SizedBox(height: 4),
//               Row(
//                 children: [
//                   const Icon(Icons.location_on_outlined, size: 16),
//                   const SizedBox(width: 2),
//                   Text(
//                     job.location,
//                     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                   ),
//                   const SizedBox(width: 8),
//                   const Icon(Icons.access_time_outlined, size: 16),
//                   const SizedBox(width: 2),
//                   Text(
//                     job.jobType,
//                     style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         _CompanyLogo(logoUrl: job.employer.companyLogo),
//       ],
//     );
//   }
// }

// class _CompanyLogo extends StatelessWidget {
//   final String? logoUrl;

//   const _CompanyLogo({this.logoUrl});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 48,
//       height: 48,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8),
//         image: logoUrl != null
//             ? DecorationImage(
//                 image: NetworkImage(logoUrl!),
//                 fit: BoxFit.cover,
//               )
//             : null,
//         color: logoUrl == null ? Colors.grey[200] : null,
//       ),
//       child: logoUrl == null ? const Icon(Icons.business, size: 24) : null,
//     );
//   }
// }

// class _JobDescription extends StatelessWidget {
//   final JobEntity job;

//   const _JobDescription({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Job Description',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           job.description.summary,
//           style: const TextStyle(
//             fontSize: 16,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _JobResponsibilities extends StatelessWidget {
//   final JobEntity job;

//   const _JobResponsibilities({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Responsibilities',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           job.description.responsibilities.join('\n'),
//           style: const TextStyle(
//             fontSize: 16,
//             height: 1.5,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _JobMeta extends StatelessWidget {
//   final JobEntity job;

//   const _JobMeta({required this.job});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _MetaItem(
//           icon: Icons.work_outline,
//           title: 'Experience Level',
//           value: job.experienceLevel,
//         ),
//         const SizedBox(height: 8),
//         _MetaItem(
//           icon: Icons.attach_money,
//           title: 'Salary',
//           value: job.salary > 0
//               ? '\$${job.salary.toStringAsFixed(0)}/year'
//               : 'Not specified',
//         ),
//         const SizedBox(height: 8),
//         _MetaItem(
//           icon: Icons.calendar_today,
//           title: 'Posted',
//           value: job.datePosted != null
//               ? '${DateTime.now().difference(job.datePosted!).inDays} days ago'
//               : 'N/A',
//         ),
//       ],
//     );
//   }
// }

// class _JobSkills extends StatelessWidget {
//   final List<String> skills;

//   const _JobSkills({required this.skills});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Skills',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           runSpacing: 8,
//           children: skills
//               .map((skill) => Chip(
//                     label: Text(skill),
//                     backgroundColor: Colors.blue[50],
//                   ))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }

// class _MetaItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String value;

//   const _MetaItem({
//     required this.icon,
//     required this.title,
//     required this.value,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, size: 18, color: Colors.grey),
//         const SizedBox(width: 8),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//             Text(
//               value,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

//
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/features/jobs/domain/entity/job_entity.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';

class JobDetailsPage extends StatefulWidget {
  final String jobId;

  const JobDetailsPage({super.key, required this.jobId});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<JobBloc>().add(GetJob(id: widget.jobId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Job Details'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<JobBloc, JobState>(
            listener: (context, state) {
              if (state is Error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<JobBloc, JobState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.job != null) {
              return _JobDetailsContent(job: state.job!);
            }

            if (state.error.isNotEmpty) {
              return Center(child: Text('Error: ${state.error}'));
            }

            return const Center(child: Text('No job details found'));
          },
        ),
      ),
    );
  }
}

class _JobDetailsContent extends StatelessWidget {
  final JobEntity job;

  const _JobDetailsContent({required this.job});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JobHeader(job: job),
          const SizedBox(height: 24),
          _JobMeta(job: job),
          const SizedBox(height: 24),
          _ActionButtons(),
          const SizedBox(height: 24),
          _JobSkills(skills: job.skillsRequired),
          const SizedBox(height: 24),
          _JobDescription(job: job),
          const SizedBox(height: 24),
          _JobResponsibilities(job: job),
        ],
      ),
    );
  }
}

class _JobHeader extends StatelessWidget {
  final JobEntity job;

  const _JobHeader({required this.job});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CompanyLogo(logoUrl: job.employer.companyLogo),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  job.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  job.employer.companyName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined, size: 16),
                    const SizedBox(width: 2),
                    Text(
                      job.location,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.access_time_outlined, size: 16),
                    const SizedBox(width: 2),
                    Text(
                      job.jobType,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompanyLogo extends StatelessWidget {
  final String? logoUrl;

  const _CompanyLogo({this.logoUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: logoUrl != null
            ? DecorationImage(
                image: NetworkImage(logoUrl!),
                fit: BoxFit.cover,
              )
            : null,
        color: logoUrl == null ? Colors.grey[200] : null,
      ),
      child: logoUrl == null
          ? const Center(child: Icon(Icons.business, size: 24))
          : null,
    );
  }
}

class _ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[50],
            foregroundColor: Colors.blue[800],
            minimumSize: const Size(120, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: const Text('Save'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[200],
            foregroundColor: Colors.grey[800],
            minimumSize: const Size(120, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: const Text('Pending'),
        ),
      ],
    );
  }
}

class _JobMeta extends StatelessWidget {
  final JobEntity job;

  const _JobMeta({required this.job});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MetaItem(
          icon: Icons.work_outline,
          title: 'Experience Level',
          value: job.experienceLevel,
        ),
        const SizedBox(height: 12),
        _MetaItem(
          icon: Icons.attach_money,
          title: 'Salary',
          value: job.salary > 0
              ? '\$${job.salary.toStringAsFixed(0)}/year'
              : 'Not specified',
        ),
        const SizedBox(height: 12),
        _MetaItem(
          icon: Icons.calendar_today,
          title: 'Posted',
          value: job.datePosted != null
              ? '${DateTime.now().difference(job.datePosted!).inDays} days ago'
              : 'N/A',
        ),
      ],
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _MetaItem({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 24, color: Colors.grey[600]),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _JobDescription extends StatelessWidget {
  final JobEntity job;

  const _JobDescription({required this.job});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Job Description',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          job.description.summary,
          style: const TextStyle(
            fontSize: 16,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _JobResponsibilities extends StatelessWidget {
  final JobEntity job;

  const _JobResponsibilities({required this.job});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Responsibilities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: job.description.responsibilities
              .map((responsibility) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      '• $responsibility',
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }
}

class _JobSkills extends StatelessWidget {
  final List<String> skills;

  const _JobSkills({required this.skills});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Required Skills',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills
              .map((skill) => Chip(
                    label: Text(skill),
                    backgroundColor: Colors.blue[50],
                  ))
              .toList(),
        ),
      ],
    );
  }
}
