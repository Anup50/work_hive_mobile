import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/core/common/components/job_card.dart';
import 'package:work_hive_mobile/features/jobs/presentation/view_model/job_bloc.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome, Bob",
                style: TextStyle(
                    fontSize: 24, fontFamily: 'PlusJakartaSans SemiBold'),
              ),
              const SizedBox(height: 10),
              TextField(
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: const Text("UI/UX"),
                          backgroundColor: Colors.white,
                          shape: StadiumBorder(
                            side: BorderSide(
                                color: Colors.grey[300]!, width: 1.5),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Chip(
                          label: const Text("Graphics Design"),
                          backgroundColor: Colors.white,
                          shape: StadiumBorder(
                            side: BorderSide(
                                color: Colors.grey[300]!, width: 1.5),
                          ),
                        ),
                      ),
                      Chip(
                        label: const Text("React"),
                        backgroundColor: Colors.white,
                        shape: StadiumBorder(
                          side:
                              BorderSide(color: Colors.grey[300]!, width: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Recommended for you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const JobCard(
                    jobTitle: "Job Title",
                    companyName: "Company Name",
                    jobLocation: "Job Location (Workplace type)",
                    subtitle: "Based on your skills",
                  ),
                  const JobCard(
                    jobTitle: "Job Title",
                    companyName: "Company Name",
                    jobLocation: "Job Location (Workplace type)",
                  ),
                  const JobCard(
                    jobTitle: "Job Title",
                    companyName: "Company Name",
                    jobLocation: "Job Location (Workplace type)",
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text("See all"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Recent Postings",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  BlocBuilder<JobBloc, JobState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.error.isNotEmpty) {
                        return Center(child: Text("Error: ${state.error}"));
                      } else if (state.jobs.isEmpty) {
                        return const Center(
                            child: Text('No recent job postings'));
                      } else {
                        return SizedBox(
                          height: 300,
                          child: ListView.builder(
                            itemCount: state.jobs.length,
                            itemBuilder: (context, index) {
                              final job = state.jobs[index];
                              return JobCard(
                                jobTitle: job.title,
                                companyName: job.employer.companyName,
                                jobLocation: job.location,
                                imagePath: job.employer.companyLogo,
                              );
                            },
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
