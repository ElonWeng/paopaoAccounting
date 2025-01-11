
import 'package:flutter/material.dart';

import '../config/routes.dart';
import '../config/style.dart';
import '../util/routes_util.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();

}


class _BottomBarState extends State<BottomBar>{

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(_selectedIndex == 1){
        RoutesUtil.navigateToPage(context,LOGIN_PAGE,{});
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 50,right: 50,bottom: 20),
      // elevation: Theme.of(context).bottomNavigationBarTheme.elevation,
      // shadowColor: Theme.of(context).colorScheme.shadow,
      // color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Style.radiusLg
        ),
        // side: BorderSide(
        //   color: Theme.of(context).shadowColor,
        //   strokeAlign: BorderSide.strokeAlignInside,
        // ),
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add_home_outlined),
            label: '事件',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: '我的',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

}