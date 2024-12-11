import 'package:flutter/material.dart';
import 'package:work_hive_mobile/app.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/logo.png",
      "title": "Welcome to Job Finder",
      "description": "Find your dream job quickly and easily."
    },
    {
      "image": "assets/images/logo.png",
      "title": "Get Hired",
      "description": "Connect with top employers and land your ideal job."
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) => OnboardingContent(
                image: onboardingData[index]["image"]!,
                title: onboardingData[index]["title"]!,
                description: onboardingData[index]["description"]!,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
              (index) => buildDot(index),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_currentPage == onboardingData.length - 1) {
                // Navigate to the home screen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              } else {
                // Move to the next page
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
            child: Text(_currentPage == onboardingData.length - 1
                ? "Get Started"
                : "Next"),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildDot(int index) {
    return Container(
      margin: EdgeInsets.only(right: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
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
