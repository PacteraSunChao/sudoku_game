import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

class SudokuController extends GetxController {
  // 游戏状态
  var board = <List<int>>[].obs;
  var solution = <List<int>>[].obs;
  var isFixed = <List<bool>>[].obs;
  var selectedRow = Rxn<int>();
  var selectedCol = Rxn<int>();
  var tappedRow = Rxn<int>();
  var tappedCol = Rxn<int>();
  var gameWon = false.obs;
  var isLoading = false.obs;

  // 新增属性
  final currentDifficulty = 'medium'.obs;
  final gameTime = 0.obs;
  final isGameStarted = false.obs;
  final isDebugMode = false.obs;
  Timer? _gameTimer;

  // 难度配置
  final Map<String, int> difficultySettings = {
    'easy': 45, // 保留45个数字
    'medium': 35, // 保留35个数字
    'hard': 25, // 保留25个数字
  };

  @override
  void onInit() {
    super.onInit();
    newGame();
  }

  @override
  void onClose() {
    _gameTimer?.cancel();
    super.onClose();
  }

  void setDifficulty(String difficulty) {
    currentDifficulty.value = difficulty;
  }

  void startTimer() {
    if (!isGameStarted.value) {
      isGameStarted.value = true;
      gameTime.value = 0;
      _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        gameTime.value++;
      });
    }
  }

  void stopTimer() {
    _gameTimer?.cancel();
    isGameStarted.value = false;
  }

  void resetTimer() {
    _gameTimer?.cancel();
    gameTime.value = 0;
    isGameStarted.value = false;
  }

  void toggleDebugMode() {
    isDebugMode.value = !isDebugMode.value;
    if (isDebugMode.value) {
      _fillAllNumbers();
    } else {
      // 退出debug模式时重新开始游戏
      newGame();
    }
  }

  void _fillAllNumbers() {
    // 将solution的所有数字填入board
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        board[i][j] = solution[i][j];
      }
    }
    update();
  }

  void newGame() {
    resetTimer();
    isLoading.value = true;

    // 重置游戏状态
    board.value = List.generate(9, (_) => List.filled(9, 0));
    solution.value = List.generate(9, (_) => List.filled(9, 0));
    isFixed.value = List.generate(9, (_) => List.filled(9, false));
    selectedRow.value = null;
    selectedCol.value = null;
    gameWon.value = false;
    isDebugMode.value = false; // 重置debug模式

    // 生成完整的数独解决方案
    _generateSolution();

    // 复制解决方案到游戏板
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        board[i][j] = solution[i][j];
      }
    }

    // 随机移除一些数字来创建谜题
    _createPuzzle();

    isLoading.value = false;
    update();
  }

  void generateNewGame() {
    newGame();
  }

  void _generateSolution() {
    _solveSudoku(solution);
  }

  bool _solveSudoku(List<List<int>> grid) {
    for (int row = 0; row < 9; row++) {
      for (int col = 0; col < 9; col++) {
        if (grid[row][col] == 0) {
          List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
          numbers.shuffle(Random());

          for (int num in numbers) {
            if (_isValidMove(grid, row, col, num)) {
              grid[row][col] = num;
              if (_solveSudoku(grid)) {
                return true;
              }
              grid[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  bool _isValidMove(List<List<int>> grid, int row, int col, int num) {
    // 检查行
    for (int i = 0; i < 9; i++) {
      if (grid[row][i] == num) return false;
    }

    // 检查列
    for (int i = 0; i < 9; i++) {
      if (grid[i][col] == num) return false;
    }

    // 检查3x3方格
    int boxRow = (row ~/ 3) * 3;
    int boxCol = (col ~/ 3) * 3;
    for (int i = boxRow; i < boxRow + 3; i++) {
      for (int j = boxCol; j < boxCol + 3; j++) {
        if (grid[i][j] == num) return false;
      }
    }

    return true;
  }

  void _createPuzzle() {
    Random random = Random();
    int cellsToKeep = difficultySettings[currentDifficulty.value] ?? 35;
    int cellsToRemove = 81 - cellsToKeep; // 总共81个格子

    // 创建所有位置的列表
    List<List<int>> allPositions = [];
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        allPositions.add([i, j]);
      }
    }

    // 打乱位置顺序
    allPositions.shuffle(random);

    // 统计每行、每列、每九宫格已移除的数字数量
    List<int> rowRemoved = List.filled(9, 0);
    List<int> colRemoved = List.filled(9, 0);
    List<int> boxRemoved = List.filled(9, 0);

    int removed = 0;
    int maxPerRow = (cellsToRemove / 9).ceil() + 1; // 每行最多移除的数字数
    int maxPerCol = (cellsToRemove / 9).ceil() + 1; // 每列最多移除的数字数
    int maxPerBox = (cellsToRemove / 9).ceil() + 1; // 每九宫格最多移除的数字数

    for (List<int> pos in allPositions) {
      if (removed >= cellsToRemove) break;

      int row = pos[0];
      int col = pos[1];
      int boxIndex = (row ~/ 3) * 3 + (col ~/ 3);

      // 检查是否可以移除这个位置的数字（避免过度聚集）
      if (rowRemoved[row] < maxPerRow &&
          colRemoved[col] < maxPerCol &&
          boxRemoved[boxIndex] < maxPerBox &&
          board[row][col] != 0) {
        board[row][col] = 0;
        rowRemoved[row]++;
        colRemoved[col]++;
        boxRemoved[boxIndex]++;
        removed++;
      }
    }

    // 如果还需要移除更多数字，进行第二轮移除（放宽限制）
    if (removed < cellsToRemove) {
      allPositions.shuffle(random);
      for (List<int> pos in allPositions) {
        if (removed >= cellsToRemove) break;

        int row = pos[0];
        int col = pos[1];

        if (board[row][col] != 0) {
          board[row][col] = 0;
          removed++;
        }
      }
    }

    // 标记固定的数字
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        isFixed[i][j] = board[i][j] != 0;
      }
    }
  }

  void selectCell(int row, int col) {
    if (!isFixed[row][col]) {
      selectedRow.value = row;
      selectedCol.value = col;
      startTimer(); // 开始计时
    }
  }

  void onCellTapDown(int row, int col) {
    tappedRow.value = row;
    tappedCol.value = col;
    update();
  }

  void onCellTapUp() {
    tappedRow.value = null;
    tappedCol.value = null;
    update();
  }

  void inputNumber(int number) {
    if (selectedRow.value != null &&
        selectedCol.value != null &&
        !isFixed[selectedRow.value!][selectedCol.value!]) {
      board[selectedRow.value!][selectedCol.value!] = number;
      _checkWin();
      update();
    }
  }

  void clearCell() {
    if (selectedRow.value != null &&
        selectedCol.value != null &&
        !isFixed[selectedRow.value!][selectedCol.value!]) {
      board[selectedRow.value!][selectedCol.value!] = 0;
      update();
    }
  }

  void _checkWin() {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        if (board[i][j] == 0 || board[i][j] != solution[i][j]) {
          return;
        }
      }
    }

    // 游戏胜利
    gameWon.value = true;
    stopTimer();

    _showWinDialog();
  }

  String getDifficultyText() {
    switch (currentDifficulty.value) {
      case 'easy':
        return '简单';
      case 'medium':
        return '中等';
      case 'hard':
        return '困难';
      default:
        return '未知';
    }
  }

  String formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void _showWinDialog() {
    Get.dialog(
      GetBuilder<SudokuController>(
        builder: (controller) => AlertDialog(
          title: const Text('恭喜！'),
          content: const Text('你成功完成了数独游戏！'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
                Get.offAllNamed('/home');
              },
              child: const Text('返回'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                generateNewGame();
              },
              child: const Text('新游戏'),
            ),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  // 获取单元格颜色
  Color getCellColor(int row, int col) {
    // 点击状态 - 最高优先级
    if (tappedRow.value == row && tappedCol.value == col) {
      return Get.theme.colorScheme.primary.withOpacity(0.6);
    }
    // 选中状态
    if (selectedRow.value == row && selectedCol.value == col) {
      return Get.theme.colorScheme.primary.withOpacity(0.3);
    }
    // Debug模式下的填充数字
    if (isDebugMode.value && board[row][col] != 0 && !isFixed[row][col]) {
      return Colors.orange.withOpacity(0.2);
    }
    // 固定数字
    if (isFixed[row][col]) {
      return Get.theme.colorScheme.surfaceVariant;
    }
    // 错误数字
    if (board[row][col] != 0 && board[row][col] != solution[row][col]) {
      return Get.theme.colorScheme.error.withOpacity(0.3);
    }
    return Get.theme.colorScheme.surface;
  }

  // 获取文本颜色
  Color getTextColor(int row, int col) {
    // Debug模式下的填充数字
    if (isDebugMode.value && board[row][col] != 0 && !isFixed[row][col]) {
      return Colors.orange;
    }
    if (isFixed[row][col]) {
      return Get.theme.colorScheme.onSurface;
    }
    return Get.theme.colorScheme.primary;
  }

  // 获取字体粗细
  FontWeight getFontWeight(int row, int col) {
    return isFixed[row][col] ? FontWeight.bold : FontWeight.normal;
  }
}
