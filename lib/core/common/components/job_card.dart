// import 'package:flutter/material.dart';
// import 'package:work_hive_mobile/app/utils/image_url_util.dart';

// class JobCard extends StatefulWidget {
//   const JobCard({
// super.key,
// required this.jobTitle,
// required this.companyName,
// required this.jobLocation,
// this.imagePath,
// this.subtitle,
//   });

// final String jobTitle;
// final String companyName;
// final String jobLocation;
// final String? subtitle;
// final String? imagePath;

//   @override
//   State<JobCard> createState() => _JobCardState();
// }

// class _JobCardState extends State<JobCard> {
//   bool isBookmarked = false;
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       color: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           children: [
//             // Job Image or Placeholder
//             Container(
//               width: 50,
//               height: 50,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 image: widget.imagePath != null
//                     ? DecorationImage(
//                         image: NetworkImage(
//                           getImageUrl(widget.imagePath),
//                         ),
//                         fit: BoxFit.cover,
//                       )
//                     : null,
//                 color: widget.imagePath == null ? Colors.grey[300] : null,
//               ),
//               child: widget.imagePath == null
//                   ? Icon(Icons.image_not_supported, color: Colors.grey[600])
//                   : null,
//             ),
//             const SizedBox(width: 16),
//             // Job Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.jobTitle,
//                     style: const TextStyle(
//                         fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     widget.companyName,
//                     style: TextStyle(fontSize: 14, color: Colors.grey[700]),
//                   ),
//                   Text(
//                     widget.jobLocation,
//                     style: TextStyle(fontSize: 12, color: Colors.grey[600]),
//                   ),
//                   if (widget.subtitle != null) ...[
//                     const SizedBox(height: 8),
//                     Text(
//                       widget.subtitle!,
//                       style: const TextStyle(fontSize: 12, color: Colors.blue),
//                     ),
//                   ],
//                 ],
//               ),
//             ),

//             IconButton(
//               icon: Icon(
//                 isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
//                 color: isBookmarked ? Colors.blue : Colors.grey,
//               ),
//               onPressed: () {
//                 setState(() {
//                   isBookmarked = !isBookmarked;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/app/utils/image_url_util.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view/job_details_view.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';

class JobCard extends StatefulWidget {
  const JobCard({
    super.key,
    required this.jobTitle,
    required this.companyName,
    required this.jobLocation,
    this.imagePath,
    this.subtitle,
  });

  final String jobTitle;
  final String companyName;
  final String jobLocation;
  final String? subtitle;
  final String? imagePath;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Wrap Card with GestureDetector
      // onTap: () {
      //   final jobId = (widget.key as ValueKey<String>).value;
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => JobDetailsPage(jobId: jobId),
      //     ),
      //   );
      // },
      // onTap: () {
      //   final jobId = (widget.key as ValueKey<String?>?)?.value;
      //    final jobBloc = context.read<JobBloc>();
      //   if (jobId != null) {

      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => JobDetailsPage(jobId: jobId),
      //       ),
      //     );
      //   } else {
      //     debugPrint('Job ID is null. Navigation not possible.');
      //   }
      // },
      onTap: () {
        final jobId = (widget.key as ValueKey<String?>?)?.value;
        final jobBloc = context.read<JobBloc>();

        if (jobId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                // Pass the JobBloc
                value: jobBloc,
                child: JobDetailsPage(jobId: jobId),
              ),
            ),
          );
        } else {
          debugPrint('Job ID is null. Navigation not possible.');
        }
      },

      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Job Image or Placeholder
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: widget.imagePath != null
                      ? DecorationImage(
                          image: NetworkImage(
                            getImageUrl(widget.imagePath),
                          ),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: widget.imagePath == null ? Colors.grey[300] : null,
                ),
                child: widget.imagePath == null
                    ? Icon(Icons.image_not_supported, color: Colors.grey[600])
                    : null,
              ),
              const SizedBox(width: 16),
              // Job Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.jobTitle,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.companyName,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    Text(
                      widget.jobLocation,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.subtitle!,
                        style:
                            const TextStyle(fontSize: 12, color: Colors.blue),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
                  color: isBookmarked ? Colors.blue : Colors.grey,
                ),
                onPressed: () {
                  setState(() {
                    isBookmarked = !isBookmarked;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
