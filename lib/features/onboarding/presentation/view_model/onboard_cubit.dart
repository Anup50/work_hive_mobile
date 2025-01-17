import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void setPage(int index) {
    emit(index);
  }

  void nextPage(PageController controller) {
    if (!isLastPage) {
      controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool get isLastPage => state == 4;
}
