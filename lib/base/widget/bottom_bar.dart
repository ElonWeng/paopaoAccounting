
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


class _BottomBarState extends State<BottomBar>{


  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      widget.onIndexChanged?.call(index); // 调用回调函数，传递新索引
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Style.radiusLg
        ),
        // side: BorderSide(
        //   color: Theme.of(context).shadowColor,
        //   strokeAlign: BorderSide.strokeAlignInside,
        // ),
      ),
      child: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(
            icon: const Icon(Icons.add_home_outlined),
            label: LocalizationService.of(context).translate('home'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_2_outlined),
            label: LocalizationService.of(context).translate('profile'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

}