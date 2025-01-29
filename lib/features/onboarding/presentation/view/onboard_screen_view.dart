import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:work_hive_mobile/app/di/di.dart';
import 'package:work_hive_mobile/features/auth/presentation/view/signin_view.dart';
import 'package:work_hive_mobile/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:work_hive_mobile/features/onboarding/presentation/view_model/onboard_cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    final onboardingPages = [
      const OnboardingContent(
        image: "assets/images/logo.png",
        title: "Welcome to WorkHive",
        description: "Find your dream job quickly and easily.",
      ),
      const OnboardingContent(
        image: "assets/images/undraw_Mobile_search_jxq5.png",
        title: "Search for Jobs",
        description: "Explore a wide range of jobs that match your skills.",
      ),
      const OnboardingContent(
        image: "assets/images/0297ccab833e9d198ce973971f5d8342.png",
        title: "Build your CV",
        description:
            "Create a professional CV with ease to showcase your skills and stand out to employers.",
      ),
      const OnboardingContent(
        image: "assets/images/undraw_Note_list_re_r4u9.png",
        title: "Track Applications",
        description: "Stay organized and track all your job applications.",
      ),
      const OnboardingContent(
        image: "assets/images/undraw_Interview_re_e5jn.png",
        title: "Get Hired",
        description: "Land your dream job with our powerful tools.",
      ),
    ];

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
                    if (context.read<OnboardingCubit>().isLastPage) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return BlocProvider<LoginBloc>(
                              create: (_) => getIt<LoginBloc>(),
                              child: SignInPage(),
                            );
                          },
                        ),
                      );
                    } else {
                      pageController.jumpToPage(4);
                      context.read<OnboardingCubit>().setPage(4);
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
                controller: pageController,
                itemCount: onboardingPages.length,
                onPageChanged: (index) {
                  context.read<OnboardingCubit>().setPage(index);
                },
                itemBuilder: (context, index) {
                  return onboardingPages[index];
                },
              ),
            ),
            BlocBuilder<OnboardingCubit, int>(
              builder: (context, currentPage) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    onboardingPages.length,
                    (index) => buildDot(index, currentPage),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                final onboardingCubit = context.read<OnboardingCubit>();

                if (onboardingCubit.isLastPage) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return BlocProvider<LoginBloc>(
                          create: (_) => getIt<LoginBloc>(),
                          child: SignInPage(),
                        );
                      },
                    ),
                  );
                } else {
                  onboardingCubit.nextPage(pageController);
                }
              },
              child: Text(
                context.read<OnboardingCubit>().isLastPage
                    ? "Get Started"
                    : "Next",
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
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
        Image.asset(image, height: 300),
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
