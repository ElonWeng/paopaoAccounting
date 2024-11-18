import 'package:flutter/material.dart';

class InputBgWidget extends StatefulWidget {
  final double? height;
  final Widget child;

  const InputBgWidget({
    Key? key,
    this.height=50,
    required this.child,
  }) : super(key: key);

  @override
  InputBgWidgetState createState() => InputBgWidgetState();
}

class InputBgWidgetState extends State<InputBgWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.black12, // 设置边框颜色
          width: 1, // 设置边框宽度
        ),
      ),
      child: widget.child,
    );
  }
}
