import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MePage extends StatelessWidget {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 设置状态栏为透明并覆盖内容
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // 状态栏透明
        statusBarIconBrightness: Brightness.light, // 状态栏图标为白色
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true, // 让背景扩展到状态栏
      body: Stack(
        children: [
          // 背景纯黑
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
            ),
          ),
          // 内容布局
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80), // 确保顶部有一定的间距
              const Text(
                "欢迎来到“众”社区",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // 注册按钮
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // 注册逻辑
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("注册按钮点击")),
                      );
                    },
                    child: const Text(
                      "注册",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  // 登录按钮
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      // 登录逻辑
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("登录按钮点击")),
                      );
                    },
                    child: const Text(
                      "登录",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}
