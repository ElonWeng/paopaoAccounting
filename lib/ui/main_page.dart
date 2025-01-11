import 'package:flutter/material.dart';
import 'package:paopao_accounting/base/config/routes.dart';
import 'package:paopao_accounting/ui/main/home/HomePage.dart';

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
    Center(child: Text('Profile')),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: BaseProviderWidget(
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomBar()
    );
  }
}
