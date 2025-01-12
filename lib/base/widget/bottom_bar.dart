import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/style.dart';
import '../util/localization_service.dart';
import '../util/routes_util.dart';

typedef IndexChangedListener = void Function(int index);

class BottomBar extends StatefulWidget {
  final IndexChangedListener? onIndexChanged;
  final int initialIndex;
  const BottomBar({Key? key, this.onIndexChanged, required this.initialIndex}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onIndexChanged?.call(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 50),
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.add_home_outlined),
                  label: LocalizationService.of(context).translate('home'),
                  backgroundColor: Colors.blue, // 添加蓝色背景
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.person_2_outlined),
                  label: LocalizationService.of(context).translate('profile'),
                  backgroundColor: Colors.red, // 添加红色背景
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: Colors.blue, // 选中项为蓝色
              unselectedItemColor: Colors.red, // 未选中项为红色
            ),
          ),
        ),
      ),
    );
  }
}