import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/toast_provider.dart';

class ToastWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final toastProvider = Provider.of<ToastProvider>(context,listen: false);

    if (!toastProvider.isVisible) return Container();

    return SnackBar(
      content: Text(toastProvider.message),
      action: SnackBarAction(
        label: '关闭',
        onPressed: () {
          toastProvider.showToast(''); // 调用showToast来清空消息，实际上可以封装一个hide方法
        },
      ),
      duration: Duration.zero, // 因为我们自己控制显示时间
    );
  }
}