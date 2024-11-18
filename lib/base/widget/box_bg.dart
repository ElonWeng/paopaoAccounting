import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BoxBgWidget extends StatefulWidget {
  final double? height;
  final double? width;
  final TextEditingController editingController;

  const BoxBgWidget({Key? key, this.height, this.width, required this.editingController})
      : super(key: key);

  @override
  BoxBgWidgetState createState() => BoxBgWidgetState();
}

class BoxBgWidgetState extends State<BoxBgWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      // 你可以根据需要调整padding、margin和width
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5), // 灰色半透明背景
        borderRadius: BorderRadius.circular(10.0), // 圆角
      ),
      child: TextField(
        controller: widget.editingController,
        onChanged: (value) {
          if (value.length == 1) {
            // 假设我们想要在用户输入5个字符后自动跳到下一个输入框
            FocusScope.of(context).nextFocus();
          }
        },
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly // 只允许输入数字
        ],
        decoration: const InputDecoration(
          // 移除默认的边框和填充
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 10.0), // 调整左右内边距
          // 注意：这里没有直接设置文本居中的属性
        ),
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
