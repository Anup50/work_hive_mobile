import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/app/di/di.dart';
import 'package:work_hive_mobile/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        BlocProvider(
          create: (context) => getIt<JobBloc>(),
          child: const DashboardView(),
        ),
        const Center(
          child: Text('Applications'), // Placeholder for Applications tab
        ),
        // BlocProvider(
        //   create: (context) => getIt<BatchBloc>(),
        //   child: BatchView(),
        // ),
        const Center(
          child: Text('Account'),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
