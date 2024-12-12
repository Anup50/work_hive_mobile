import 'package:flutter/material.dart';
import 'package:work_hive_mobile/common/components/job_card.dart';

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
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome, Bob",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search Here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    CategoryChip(label: "UI/UX"),
                    CategoryChip(label: "Graphics Design"),
                    CategoryChip(label: "React"),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Recommended for you",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              JobCard(
                jobTitle: "Job Title",
                companyName: "Company Name",
                jobLocation: "Job Location (Workplace type)",
                subtitle: "Based on your skills",
              ),
              JobCard(
                jobTitle: "Job Title",
                companyName: "Company Name",
                jobLocation: "Job Location (Workplace type)",
              ),
              TextButton(
                onPressed: () {},
                child: Text("See all"),
              ),
              SizedBox(height: 16),
              Text(
                "Recent Postings",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              JobCard(
                jobTitle: "Job Title",
                companyName: "Company Name",
                jobLocation: "Job Location (Workplace type)",
              ),
              JobCard(
                jobTitle: "Job Title",
                companyName: "Company Name",
                jobLocation: "Job Location (Workplace type)",
              ),
              JobCard(
                jobTitle: "Job Title",
                companyName: "Company Name",
                jobLocation: "Job Location (Workplace type)",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.work), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ""),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.blue[100],
      ),
    );
  }
}
