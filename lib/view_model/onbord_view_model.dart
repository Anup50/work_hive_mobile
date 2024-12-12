import 'package:flutter/material.dart';

// class OnboardingViewModel extends ChangeNotifier {
//   int _currentPage = 0;
//   int get currentPage => _currentPage;

//   void setPage(int index) {
//     _currentPage = index;
//     notifyListeners();
//   }

//   void nextPage(PageController controller) {
//     controller.nextPage(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.ease,
//     );
//     _currentPage++;
//     notifyListeners();
//   }

//   bool get isLastPage => _currentPage == 1;
// }
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
    // Update this to dynamically check against the number of pages
    return currentPage == 4; // Change 3 to the index of the last page
  }
}
