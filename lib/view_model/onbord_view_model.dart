import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  int currentPage = 0;

  void setPage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void nextPage(PageController controller) {
    if (!isLastPage) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool get isLastPage {
    return currentPage == 4;
  }
}
