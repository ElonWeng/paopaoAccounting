// 示例的服务条款页面
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class  ServiceTermsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('服务条款'),
      ),
      body: Center(
        child: Text('这里是服务条款的内容。'),
      ),
    );
  }
}