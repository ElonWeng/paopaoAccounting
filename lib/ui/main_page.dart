import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paopao_accounting/ui/main/home/HomePage.dart';
import 'package:paopao_accounting/ui/me/me_page.dart';

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
          // 背景设置为纯黑
          Container(
            color: Colors.black.withOpacity(0.9),
          ),
          // 内容布局
          Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        backgroundColor: Colors.white, // 底部导航栏背景黑色
        selectedItemColor: Colors.blueAccent, // 选中图标和文字的颜色
        unselectedItemColor: Colors.redAccent, // 未选中图标和文字的颜色
      ),
    );
  }
}
