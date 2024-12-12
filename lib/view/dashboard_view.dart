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
      backgroundColor: Colors.white,
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
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: "Search Here",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide(
                        color: Colors.grey[300]!), 
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
                    mainAxisAlignment:
                        MainAxisAlignment.center, 
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0), 
                        child: Chip(
                          label: const Text("UI/UX"),
                          backgroundColor:
                              Colors.white, 
                          shape: StadiumBorder(
                           
                            side: BorderSide(
                                color: Colors.grey[300]!,
                                width: 1.5), 
                          ),
                        ),
                      ),

                      // Graphics Design Chip
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0), 
                        child: Chip(
                          label: const Text("Graphics Design"),
                          backgroundColor:
                              Colors.white, 
                          shape: StadiumBorder(
                           
                            side: BorderSide(
                                color: Colors.grey[300]!,
                                width: 1.5), 
                          ),
                        ),
                      ),

                      Chip(
                        label: const Text("React"),
                        backgroundColor:
                            Colors.white, 
                        shape: StadiumBorder(

                          side: BorderSide(
                              color: Colors.grey[300]!,
                              width: 1.5), 
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
                  const JobCard(
                    jobTitle: "Job Title",
                    companyName: "Company Name",
                    jobLocation: "Job Location (Workplace type)",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const [
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

  const CategoryChip({super.key, required this.label});

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
