import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/sudoku_game_view.dart';
import '../views/difficulty_selection_view.dart';
import '../controllers/sudoku_controller.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.home;

  static final routes = [
    GetPage(name: AppRoutes.home, page: () => const HomeView()),
    GetPage(
      name: AppRoutes.difficultySelection,
      page: () => const DifficultySelectionView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SudokuController>(() => SudokuController());
      }),
    ),
    GetPage(
      name: AppRoutes.sudokuGame,
      page: () => const SudokuGameView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<SudokuController>(() => SudokuController());
      }),
    ),
  ];
}
