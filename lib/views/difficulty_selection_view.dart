import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../controllers/sudoku_controller.dart';

class DifficultySelectionView extends StatelessWidget {
  const DifficultySelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              const SizedBox(height: 40),

              // 页面标题
              Text(
                '选择你的挑战难度',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 50),

              // 简单难度
              _buildDifficultyCard(
                title: '简单',
                subtitle: '适合初学者',
                description: '较多提示数字，轻松入门',
                color: Colors.green,
                icon: Icons.sentiment_satisfied,
                onTap: () => _startGame('easy'),
              ),

              const SizedBox(height: 20),

              // 中等难度
              _buildDifficultyCard(
                title: '中等',
                subtitle: '适合有经验的玩家',
                description: '中等数量的提示，需要一定技巧',
                color: Colors.orange,
                icon: Icons.sentiment_neutral,
                onTap: () => _startGame('medium'),
              ),

              const SizedBox(height: 20),

              // 困难难度
              _buildDifficultyCard(
                title: '困难',
                subtitle: '适合专家级玩家',
                description: '极少提示数字，挑战你的极限',
                color: Colors.red,
                icon: Icons.sentiment_very_dissatisfied,
                onTap: () => _startGame('hard'),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyCard({
    required String title,
    required String subtitle,
    required String description,
    required Color color,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 8,
        shadowColor: color.withOpacity(0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Icon(icon, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: color, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startGame(String difficulty) {
    // 获取控制器并设置难度
    final controller = Get.find<SudokuController>();
    controller.setDifficulty(difficulty);
    controller.newGame();

    // 导航到游戏页面
    Get.toNamed(AppRoutes.sudokuGame);
  }
}
