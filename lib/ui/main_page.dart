import 'package:flutter/material.dart';
import 'package:paopao_accounting/base/config/routes.dart';
import 'package:paopao_accounting/ui/main/home/HomePage.dart';
import 'package:paopao_accounting/ui/me/me_page.dart';

import '../base/util/localization_service.dart';
import '../base/util/routes_util.dart';
import '../base/widget/base_page.dart';
import '../base/widget/bottom_bar.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(LocalizationService.of(context).translate('app_name')),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home_outlined),
            label: LocalizationService.of(context).translate('home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.heart_broken_outlined),
            label: LocalizationService.of(context).translate('profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
