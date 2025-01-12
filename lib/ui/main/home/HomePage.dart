
import 'package:flutter/material.dart';
import 'package:paopao_accounting/base/config/routes.dart';
import 'package:paopao_accounting/base/util/routes_util.dart';

class HomePage extends StatefulWidget{
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();


}

class _HomePageState extends State<HomePage>{
  int _counter = 0;

  void _incrementCounter() {
    RoutesUtil.navigateToPage(context, LOGIN_PAGE, {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text('这是首页')
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }

}