import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 游戏标题
              Container(
                margin: const EdgeInsets.only(bottom: 60),
                child: Column(
                  children: [
                    Text(
                      '数独游戏',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                        shadows: [
                          Shadow(
                            offset: const Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.grey.withOpacity(0.3),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Sudoku Game',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[600],
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),

              // 选择难度按钮
              Container(
                width: double.infinity,
                height: 60,
                margin: const EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.difficultySelection);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.blue.withOpacity(0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.play_arrow, size: 28),
                      const SizedBox(width: 10),
                      Text(
                        '选择难度',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),



              // 底部装饰
              Container(
                margin: const EdgeInsets.only(top: 60),
                child: Column(
                  children: [
                    Icon(Icons.grid_3x3, size: 40, color: Colors.grey[400]),
                    const SizedBox(height: 10),
                    Text(
                      '挑战你的逻辑思维',
                      style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
