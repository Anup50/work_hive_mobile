// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart'; // Import provider
// import 'package:work_hive_mobile/view/signup_view.dart';
// import 'package:work_hive_mobile/view_model/onbord_view_model.dart';

// class OnboardingScreen extends StatelessWidget {
//   const OnboardingScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // PageController for managing the page navigation
//     final PageController pageController = PageController();
//     final viewModel = Provider.of<OnboardingViewModel>(context);

//     // Define the onboarding pages content
//     final onboardingPages = [
//       const OnboardingContent(
//         image: "assets/images/logo.png",
//         title: "Welcome to WorkHive",
//         description: "Find your dream job quickly and easily.",
//       ),
//       const OnboardingContent(
//         image: "assets/images/undraw_Mobile_search_jxq5.png",
//         title: "Search for Jobs",
//         description: "Explore a wide range of jobs that match your skills.",
//       ),
//       const OnboardingContent(
//         image: "assets/images/0297ccab833e9d198ce973971f5d8342.png",
//         title: "Build your CV",
//         description:
//             "Create a professional CV with ease to showcase your skills and stand out to employers.",
//       ),
//       const OnboardingContent(
//         image: "assets/images/undraw_Note_list_re_r4u9.png",
//         title: "Track Applications",
//         description: "Stay organized and track all your job applications.",
//       ),
//       const OnboardingContent(
//         image: "assets/images/undraw_Interview_re_e5jn.png",
//         title: "Get Hired",
//         description: "Land your dream job with our powerful tools.",
//       ),
//     ];

//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Align(
//                 alignment: Alignment.topRight,
//                 child: TextButton(
//                   onPressed: () {
//                     if (viewModel.isLastPage) {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const SignUpPage()),
//                       );
//                     } else {
//                       pageController.jumpToPage(onboardingPages.length - 1);
//                       viewModel.setPage(onboardingPages.length - 1);
//                     }
//                   },
//                   child: const Text(
//                     "Skip",
//                     style: TextStyle(fontSize: 16, color: Colors.blue),
//                   ),
//                 ),
//               ),
//             ),
//             Expanded(
//               child: PageView.builder(
//                 controller: pageController,
//                 onPageChanged: (index) {
//                   viewModel.setPage(index);
//                 },
//                 itemCount: onboardingPages.length,
//                 itemBuilder: (context, index) => onboardingPages[index],
//               ),
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(
//                 onboardingPages.length,
//                 (index) => buildDot(index, viewModel.currentPage),
//               ),
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//               onPressed: () {
//                 if (viewModel.isLastPage) {
//                   // Navigate to the home screen when on the last page
//                   Navigator.pushReplacement(
//                     context,
//                     MaterialPageRoute(builder: (context) => const SignUpPage()),
//                   );
//                 } else {
//                   // Navigate to the next page using the ViewModel
//                   viewModel.nextPage(pageController);
//                 }
//               },
//               child: Text(viewModel.isLastPage ? "Get Started" : "Next"),
//             ),
//             const SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildDot(int index, int currentPage) {
//     return Container(
//       margin: const EdgeInsets.only(right: 5),
//       height: 10,
//       width: currentPage == index ? 20 : 10,
//       decoration: BoxDecoration(
//         color: currentPage == index ? Colors.blue : Colors.grey,
//         borderRadius: BorderRadius.circular(5),
//       ),
//     );
//   }
// }

// class OnboardingContent extends StatelessWidget {
//   final String image, title, description;

//   const OnboardingContent({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset(image, height: 300), // Add your asset images
//         const SizedBox(height: 20),
//         Text(
//           title,
//           style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 10),
//         Text(
//           description,
//           textAlign: TextAlign.center,
//           style: TextStyle(fontSize: 16, color: Colors.grey[600]),
//         ),
//       ],
//     );
//   }
// }
