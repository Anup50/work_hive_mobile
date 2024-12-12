import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:work_hive_mobile/view/dashboard_view.dart';
import 'package:work_hive_mobile/view_model/onbord_view_model.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // PageController for managing the page navigation
    final PageController _pageController = PageController();
    final viewModel =
        Provider.of<OnboardingViewModel>(context); // Access ViewModel

    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  // Skip to the last page or home screen
                  if (viewModel.isLastPage) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DashboardView()),
                    );
                  } else {
                    _pageController.jumpToPage(1); // Skip to last page directly
                    viewModel.setPage(1); // Update the page index in ViewModel
                  }
                },
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                viewModel
                    .setPage(index); // Update the current page in ViewModel
              },
              itemCount: 2, // Update this based on your onboarding data length
              itemBuilder: (context, index) => const OnboardingContent(
                image: "assets/images/logo.png", // Example image
                title: "Welcome to Job Finder", // Example title
                description:
                    "Find your dream job quickly and easily.", // Example description
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2, // Same here, should be based on the number of onboarding pages
              (index) => buildDot(index, viewModel.currentPage),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (viewModel.isLastPage) {
                // Navigate to the home screen when on the last page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DashboardView()),
                );
              } else {
                // Navigate to the next page using the ViewModel
                viewModel.nextPage(_pageController);
              }
            },
            child: Text(viewModel.isLastPage ? "Get Started" : "Next"),
          ),
          SizedBox(height: 20),
        ],
      ),
    ));
  }

  Widget buildDot(int index, int currentPage) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final String image, title, description;

  const OnboardingContent({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(image, height: 300), // Add your asset images
        SizedBox(height: 20),
        Text(
          title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
