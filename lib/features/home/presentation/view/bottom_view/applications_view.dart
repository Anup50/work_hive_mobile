import 'package:flutter/material.dart';
import 'package:work_hive_mobile/core/common/components/application_card.dart';

class ApplicationPage extends StatelessWidget {
  const ApplicationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Applications'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: const [
          ApplicationCard(
            companyLogoUrl: 'https://via.placeholder.com/150',
            jobTitle: 'Software Engineer',
            companyName: 'Tech Corp',
            jobLocation: 'New York',
            jobType: 'Full Time',
            status: 'Pending',
          ),
          ApplicationCard(
            companyLogoUrl: 'https://via.placeholder.com/150',
            jobTitle: 'UI/UX Designer',
            companyName: 'Design Studio',
            jobLocation: 'San Francisco',
            jobType: 'Part Time',
            status: 'Shortlisted',
          ),
          ApplicationCard(
            companyLogoUrl: 'https://via.placeholder.com/150',
            jobTitle: 'Project Manager',
            companyName: 'Business Inc.',
            jobLocation: 'Remote',
            jobType: 'Contract',
            status: 'Accepted',
          ),
          ApplicationCard(
            companyLogoUrl: 'https://via.placeholder.com/150',
            jobTitle: 'Data Analyst',
            companyName: 'Analytics Co.',
            jobLocation: 'Chicago',
            jobType: 'Full Time',
            status: 'Rejected',
          ),
        ],
      ),
    );
  }
}
