import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  int _currentPage = 0;
  int get currentPage => _currentPage;

  void setPage(int index) {
    _currentPage = index;
    notifyListeners(); // Notify listeners to rebuild UI
  }

  void nextPage(PageController controller) {
    controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    _currentPage++;
    notifyListeners();
  }

  bool get isLastPage => _currentPage == 1; // Adjust according to your data length
}
