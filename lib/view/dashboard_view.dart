import 'package:flutter/material.dart';

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
        toolbarHeight: 0, // Hides the AppBar for the status bar look
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Text(
                "Welcome, Bob",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              // Search Bar
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
              // Categories
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
              // Recommended for You Section
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
              // Recent Postings Section
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

  CategoryChip({required this.label});

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

class JobCard extends StatelessWidget {
  final String jobTitle;
  final String companyName;
  final String jobLocation;
  final String? subtitle;

  JobCard({
    required this.jobTitle,
    required this.companyName,
    required this.jobLocation,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Placeholder for Job Image
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            SizedBox(width: 16),
            // Job Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobTitle,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    companyName,
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                  ),
                  Text(
                    jobLocation,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 8),
                    Text(
                      subtitle!,
                      style: TextStyle(fontSize: 12, color: Colors.blue),
                    ),
                  ],
                ],
              ),
            ),
            // Bookmark Icon
            Icon(Icons.bookmark_outline, color: Colors.blue),
          ],
        ),
      ),
    );
  }
}
