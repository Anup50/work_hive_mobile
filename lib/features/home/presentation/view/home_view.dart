// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import 'package:work_hive_mobile/features/home/presentation/view_model/home_cubit.dart';
// // import 'package:work_hive_mobile/features/home/presentation/view_model/home_state.dart';

// // class HomeView extends StatelessWidget {
// //   const HomeView({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
// //         return state.views.elementAt(state.selectedIndex);
// //       }),
// //       bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
// //         builder: (context, state) {
// //           return BottomNavigationBar(
// //             items: const <BottomNavigationBarItem>[
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.work),
// //                 label: 'Jobs',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.list_alt),
// //                 label: 'Applications',
// //               ),
// //               BottomNavigationBarItem(
// //                 icon: Icon(Icons.person),
// //                 label: 'Account',
// //               ),
// //             ],
// //             currentIndex: state.selectedIndex,
// //             selectedItemColor: Colors.black,
// //             onTap: (index) {
// //               context.read<HomeCubit>().onTabTapped(index);
// //             },
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:work_hive_mobile/app/di/di.dart'; // Import GetIt
// import 'package:work_hive_mobile/features/home/presentation/view/bottom_view/dashboard_view.dart'; // Import DashboardView
// import 'package:work_hive_mobile/features/home/presentation/view/bottom_view/profile_view.dart';
// import 'package:work_hive_mobile/features/home/presentation/view_model/home_cubit.dart';
// import 'package:work_hive_mobile/features/home/presentation/view_model/home_state.dart';
// import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';
// import 'package:work_hive_mobile/features/jobs/presentation/view_model/search/searchjobs_bloc.dart';
// import 'package:work_hive_mobile/features/user_data/presentation/view_model/bloc/job_seeker_bloc.dart';

// class HomeView extends StatelessWidget {
//   const HomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
//         final views = state.views.asMap().entries.map((entry) {
//           final index = entry.key;
//           final view = entry.value;
//           if (index == 0 && view is DashboardView) {
//             // Check if it's the DashboardView
//             return BlocProvider<JobBloc>(
//               create: (context) => getIt<JobBloc>(),
//               child: view,
//             );

//           }
//           if (view is ProfilePage) {
//             // Check if it's the DashboardView
//             return BlocProvider<JobSeekerBloc>(
//               create: (context) => getIt<JobSeekerBloc>(),
//               child: view,
//             );
//           }
//           return view;
//         }).toList();

//         return IndexedStack(
//           // Use IndexedStack to switch between views
//           index: state.selectedIndex,
//           children: views,
//         );
//       }),
//       bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
//         builder: (context, state) {
//           return BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.work),
//                 label: 'Jobs',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.list_alt),
//                 label: 'Applications',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.person),
//                 label: 'Account',
//               ),
//             ],
//             currentIndex: state.selectedIndex,
//             selectedItemColor: Colors.black,
//             onTap: (index) {
//               context.read<HomeCubit>().onTabTapped(index);
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/app/di/di.dart';
import 'package:work_hive_mobile/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:work_hive_mobile/features/home/presentation/view_model/home_cubit.dart';
import 'package:work_hive_mobile/features/home/presentation/view_model/home_state.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/search/searchjobs_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final views = state.views.asMap().entries.map((entry) {
            final index = entry.key;
            final view = entry.value;

            if (index == 0 && view is DashboardView) {
              // Provide necessary blocs only when DashboardView is visible
              return BlocProvider(
                create: (_) => getIt<JobBloc>(),
                child: BlocProvider(
                  create: (_) => getIt<SearchjobsBloc>(),
                  child: view,
                ),
              );
            }

            // if (index == 2 && view is ProfilePage) {
            //   return BlocProvider<JobSeekerBloc>(
            //     create: (_) => getIt<JobSeekerBloc>(),
            //     child: view,
            //   );
            // }

            return view;
          }).toList();

          return IndexedStack(
            index: state.selectedIndex,
            children: views,
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: 'Jobs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Applications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Account',
              ),
            ],
            currentIndex: state.selectedIndex,
            selectedItemColor: Colors.black,
            onTap: (index) {
              context.read<HomeCubit>().onTabTapped(index);
            },
          );
        },
      ),
    );
  }
}
