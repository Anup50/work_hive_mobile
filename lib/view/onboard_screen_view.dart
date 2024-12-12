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
    final viewModel = Provider.of<OnboardingViewModel>(context);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                viewModel.setPage(index);
              },
              itemCount: 2,
              itemBuilder: (context, index) => const OnboardingContent(
                image: "assets/images/logo.png",
                title: "Welcome to Job Finder",
                description: "Find your dream job quickly and easily.",
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              2,
              (index) => buildDot(index, viewModel.currentPage),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (viewModel.isLastPage) {
                // Navigate to the home screen when on the last page
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DashboardView()),
                );
              } else {
                // Navigate to the next page using the ViewModel
                viewModel.nextPage(_pageController);
              }
            },
            child: Text(viewModel.isLastPage ? "Get Started" : "Next"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildDot(int index, int currentPage) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
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
    super.key,
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
        const SizedBox(height: 20),
        Text(
          title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
