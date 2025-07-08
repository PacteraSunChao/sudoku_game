# 数独游戏 v1.0

<div align="center">
  <h3>🧩 基于 Flutter + GetX 的现代化数独游戏</h3>
  <p>一个功能完整、界面精美的跨平台数独游戏应用</p>
  
  ![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
  ![GetX](https://img.shields.io/badge/GetX-9C27B0?style=for-the-badge&logo=flutter&logoColor=white)
  ![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
</div>

## 📖 项目简介

数独游戏是一个使用 Flutter 框架和 GetX 状态管理开发的跨平台移动应用。游戏采用现代化的 Material 3 设计语言，提供流畅的用户体验和智能的游戏算法。

### ✨ 核心特性

#### 🎮 游戏功能
- **智能数独生成**: 采用优化算法生成平衡分布的数独谜题
- **多难度选择**: 简单、中等、困难三个难度级别
- **实时计时**: 精确记录游戏时间，挑战个人最佳成绩
- **输入验证**: 实时检测错误输入，提供视觉反馈
- **调试模式**: 开发者模式，可查看完整解决方案
- **游戏状态管理**: 智能保存游戏进度和状态

#### 🎨 用户界面
- **Material 3 设计**: 采用最新的 Material Design 3 规范
- **响应式布局**: 适配不同屏幕尺寸和方向
- **主题支持**: 支持浅色和深色主题自动切换
- **流畅动画**: 精心设计的过渡动画和交互效果
- **直观操作**: 简单易懂的触摸操作和视觉提示

#### 🏗️ 技术架构
- **GetX 状态管理**: 响应式状态管理，高性能UI更新
- **模块化设计**: 清晰的代码结构和组件分离
- **内存优化**: 智能内存管理和资源释放
- **跨平台支持**: 支持 Android 和 iOS 平台

## 🚀 快速开始

### 环境要求

- Flutter SDK >= 3.8.1
- Dart SDK >= 3.8.1
- Android Studio / VS Code
- iOS 开发需要 Xcode (仅限 macOS)

### 安装步骤

1. **克隆项目**
   ```bash
   git clone <repository-url>
   cd sudoku_game
   ```

2. **安装依赖**
   ```bash
   flutter pub get
   ```

3. **运行应用**
   ```bash
   # 调试模式
   flutter run
   
   # 发布模式
   flutter run --release
   ```

4. **构建应用**
   ```bash
   # Android APK
   flutter build apk --release
   
   # iOS (需要 macOS)
   flutter build ios --release
   ```

## 📱 使用指南

### 游戏规则

数独是一个基于逻辑的数字填充游戏：

- **目标**: 在 9×9 的网格中填入数字 1-9
- **行约束**: 每行必须包含 1-9 的所有数字，不能重复
- **列约束**: 每列必须包含 1-9 的所有数字，不能重复
- **宫约束**: 每个 3×3 的子网格必须包含 1-9 的所有数字，不能重复

### 操作说明

1. **选择难度**: 在主页选择简单、中等或困难难度
2. **选择单元格**: 点击空白单元格进行选择
3. **输入数字**: 使用底部数字面板输入 1-9
4. **清除数字**: 使用退格按钮清除已输入的数字
5. **新游戏**: 点击刷新按钮开始新游戏
6. **返回主页**: 点击主页按钮返回难度选择界面
7. **调试模式**: 点击调试按钮查看完整解决方案（开发功能）

### 游戏提示

- 🟦 **蓝色高亮**: 当前选中的单元格
- 🟨 **橙色背景**: 调试模式下显示的答案
- 🟥 **红色背景**: 错误的输入数字
- ⚫ **粗体数字**: 题目预设的固定数字
- 🔵 **普通数字**: 玩家输入的数字

## 🏗️ 项目结构

```
sudoku_game/
├── lib/
│   ├── main.dart                     # 应用程序入口
│   ├── controllers/                  # GetX 控制器层
│   │   └── sudoku_controller.dart    # 数独游戏逻辑控制器
│   ├── views/                        # 视图层
│   │   ├── home_view.dart           # 主页视图
│   │   ├── difficulty_selection_view.dart  # 难度选择视图
│   │   └── sudoku_game_view.dart    # 游戏界面视图
│   └── routes/                       # 路由配置
│       ├── app_routes.dart          # 路由常量定义
│       └── app_pages.dart           # 页面路由配置
├── android/                          # Android 平台配置
├── ios/                             # iOS 平台配置
├── test/                            # 单元测试
├── pubspec.yaml                     # 项目依赖配置
└── README.md                        # 项目文档
```

## 🛠️ 技术栈

### 核心框架
- **[Flutter](https://flutter.dev/)** `^3.8.1` - 跨平台UI框架
- **[GetX](https://pub.dev/packages/get)** `^4.6.6` - 状态管理、路由管理、依赖注入

### 开发工具
- **[Dart](https://dart.dev/)** `^3.8.1` - 编程语言
- **[Flutter Lints](https://pub.dev/packages/flutter_lints)** `^5.0.0` - 代码规范检查
- **[Cupertino Icons](https://pub.dev/packages/cupertino_icons)** `^1.0.6` - iOS 风格图标

## 🎯 核心算法

### 数独生成算法

1. **完整解生成**: 使用回溯算法生成完整的数独解
2. **随机化处理**: 通过随机打乱数字顺序增加多样性
3. **平衡移除**: 智能移除数字，确保每行、列、宫的分布均匀
4. **难度控制**: 根据保留数字数量控制游戏难度

### 平衡分布优化

- **区域统计**: 实时统计每行、列、宫的数字分布
- **限制机制**: 设置每个区域的最大移除数量
- **二轮策略**: 先均匀分布，再补充移除以达到目标难度

## 🔧 开发指南

### GetX 架构优势

#### 1. 响应式状态管理
```dart
// 响应式变量
var selectedRow = Rxn<int>();
var gameTime = 0.obs;

// UI 自动更新
Obx(() => Text('时间: ${controller.formatTime(controller.gameTime.value)}'))
```

#### 2. 简化的路由管理
```dart
// 页面跳转
Get.toNamed('/game');
Get.offAllNamed('/home');

// 对话框显示
Get.dialog(AlertDialog(...));
```

#### 3. 依赖注入
```dart
// 懒加载控制器
Get.lazyPut<SudokuController>(() => SudokuController());
```

### 代码规范

- 遵循 Dart 官方代码规范
- 使用 `flutter_lints` 进行代码检查
- 采用驼峰命名法和语义化命名
- 保持代码注释的完整性和准确性

### 性能优化

- 使用 `GetBuilder` 进行局部更新
- 合理使用 `Obx` 避免过度重建
- 及时释放资源和取消订阅
- 优化算法复杂度和内存使用

## 📋 版本历史

### v1.0.0 (2024-12-24)

#### 🎉 首次发布
- ✅ 完整的数独游戏功能
- ✅ 三个难度级别（简单、中等、困难）
- ✅ 智能数独生成算法
- ✅ 平衡分布优化算法
- ✅ 实时计时功能
- ✅ 调试模式支持
- ✅ Material 3 设计语言
- ✅ GetX 状态管理架构
- ✅ 跨平台支持（Android/iOS）
- ✅ 响应式布局设计
- ✅ 完整的用户交互体验

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request 来改进这个项目！

### 提交规范

- 🐛 `fix:` 修复 bug
- ✨ `feat:` 新功能
- 📝 `docs:` 文档更新
- 🎨 `style:` 代码格式调整
- ♻️ `refactor:` 代码重构
- ⚡ `perf:` 性能优化
- ✅ `test:` 测试相关

## 📄 许可证

本项目采用 MIT 许可证 - 查看 [LICENSE](LICENSE) 文件了解详情。

---

<div align="center">
  <p>⭐ 如果这个项目对你有帮助，请给它一个星标！</p>
  <p>Made with ❤️ using Flutter & GetX</p>
</div>
