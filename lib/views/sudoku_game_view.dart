import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/sudoku_controller.dart';

class SudokuGameView extends GetView<SudokuController> {
  const SudokuGameView({super.key});

  void _onHomeButtonPressed() {
    // 检查游戏是否已开始
    if (controller.isGameStarted.value) {
      // 游戏已开始，显示确认对话框
      Get.dialog(
        AlertDialog(
          title: const Text(
            '确认返回',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            '返回主页将导致当前游戏作废，确定要返回吗？',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                '取消',
                style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(); // 关闭对话框
                controller.stopTimer(); // 停止计时器
                Get.offAllNamed('/home'); // 返回主页
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.theme.colorScheme.error,
                foregroundColor: Get.theme.colorScheme.onError,
              ),
              child: const Text(
                '确认返回',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      // 游戏未开始，直接返回主页
      Get.offAllNamed('/home');
    }
  }

  void _onRefreshButtonPressed() {
    // 检查游戏是否已开始
    if (controller.isGameStarted.value) {
      // 游戏已开始，显示确认对话框
      Get.dialog(
        AlertDialog(
          title: const Text(
            '确认重新开始',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            '重新开始将清除当前游戏进度，确定要继续吗？',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text(
                '取消',
                style: TextStyle(
                  color: Get.theme.colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Get.back(); // 关闭对话框
                controller.newGame(); // 开始新游戏
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.theme.colorScheme.primary,
                foregroundColor: Get.theme.colorScheme.onPrimary,
              ),
              child: const Text(
                '确认重新开始',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        barrierDismissible: false,
      );
    } else {
      // 游戏未开始，直接开始新游戏
      controller.newGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () => Text(
            '数独游戏 - ${controller.getDifficultyText()}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.home, color: Colors.white),
          onPressed: _onHomeButtonPressed,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: _onRefreshButtonPressed,
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: Column(
            children: [
              // 时间显示区域
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Get.theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.timer,
                        color: Get.theme.colorScheme.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        controller.formatTime(controller.gameTime.value),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Get.theme.colorScheme.onPrimaryContainer,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // 数独棋盘区域 - 中间居中
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width - 32,
                      maxHeight: MediaQuery.of(context).size.width - 32,
                    ),
                    child: AspectRatio(
                      aspectRatio: 1.0,
                      child: GetBuilder<SudokuController>(
                        builder: (controller) => GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 9,
                              ),
                          itemCount: 81,
                          itemBuilder: (context, index) {
                            int row = index ~/ 9;
                            int col = index % 9;

                            return GestureDetector(
                              onTap: () => controller.selectCell(row, col),
                              onTapDown: (_) =>
                                  controller.onCellTapDown(row, col),
                              onTapUp: (_) => controller.onCellTapUp(),
                              onTapCancel: () => controller.onCellTapUp(),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: controller.getCellColor(row, col),
                                  border: Border(
                                    left: BorderSide(
                                      color: col == 0 || col % 3 == 0
                                          ? Get.theme.colorScheme.outline
                                          : Get
                                                .theme
                                                .colorScheme
                                                .outlineVariant,
                                      width: col == 0 || col % 3 == 0 ? 2 : 1,
                                    ),
                                    top: BorderSide(
                                      color: row == 0 || row % 3 == 0
                                          ? Get.theme.colorScheme.outline
                                          : Get
                                                .theme
                                                .colorScheme
                                                .outlineVariant,
                                      width: row == 0 || row % 3 == 0 ? 2 : 1,
                                    ),
                                    right: BorderSide(
                                      color: col % 3 == 2
                                          ? Get.theme.colorScheme.outline
                                          : Get
                                                .theme
                                                .colorScheme
                                                .outlineVariant,
                                      width: col % 3 == 2 ? 2 : 1,
                                    ),
                                    bottom: BorderSide(
                                      color: row % 3 == 2
                                          ? Get.theme.colorScheme.outline
                                          : Get
                                                .theme
                                                .colorScheme
                                                .outlineVariant,
                                      width: row % 3 == 2 ? 2 : 1,
                                    ),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    controller.board[row][col] == 0
                                        ? ''
                                        : controller.board[row][col].toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: controller.getFontWeight(
                                        row,
                                        col,
                                      ),
                                      color: controller.getTextColor(row, col),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // 数字输入面板 - 置底
              _buildNumberPad(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildNumberPad() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1.0,
        children: [
          ...List.generate(9, (index) {
            int number = index + 1;
            return _buildNumberButton(number);
          }),
          _buildClearButton(),
        ],
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.inputNumber(number),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Get.theme.colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              number.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Get.theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: controller.clearCell,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.errorContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Get.theme.colorScheme.outline.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.backspace_outlined,
              size: 20,
              color: Get.theme.colorScheme.onErrorContainer,
            ),
          ),
        ),
      ),
    );
  }
}
