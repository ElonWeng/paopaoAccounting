import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 背景容器覆盖整个页面
      body: Stack(
        children: [
          // 黑色背景，90%透明度
          Container(
            color: Colors.black.withOpacity(0.9),
          ),
          // 内容布局
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: Text(
                  '这是首页',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // 文本颜色为白色，确保在深色背景上清晰显示
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
