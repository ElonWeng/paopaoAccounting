import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paopao_accounting/ui/main/home/HomePage.dart';
import 'package:paopao_accounting/ui/me/MePage.dart';

import '../base/util/localization_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    MePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          // 内容布局
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          // 自定义底部导航栏
          Positioned(
            bottom: 50, // 距离底部50px
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5, // 屏幕宽度的一半
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8), // 白色半透明
                  borderRadius: BorderRadius.circular(25), // 左右两边半圆形
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.add_home_outlined),
                        label: LocalizationService.of(context).translate('home'),
                      ),
                      BottomNavigationBarItem(
                        icon: const Icon(Icons.heart_broken_outlined),
                        label: LocalizationService.of(context).translate('profile'),
                      ),
                    ],
                    currentIndex: _selectedIndex,
                    onTap: _onItemTapped,
                    backgroundColor: Colors.transparent, // 使背景透明以显示Container的背景色
                    selectedItemColor: Colors.blueAccent,
                    unselectedItemColor: Colors.redAccent,
                    elevation: 0, // 移除默认阴影
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}