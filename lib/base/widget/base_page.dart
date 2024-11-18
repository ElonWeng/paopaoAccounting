import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paopao_accounting/base/model/loading_model.dart';
import 'package:paopao_accounting/base/model/toast_provider.dart';

class BaseProviderWidget extends StatefulWidget {
  final Widget child;

  const BaseProviderWidget({Key? key, required this.child}) : super(key: key);

  @override
  BaseProviderWidgetState createState() => BaseProviderWidgetState();
}

class BaseProviderWidgetState extends State<BaseProviderWidget> {


  @override
  Widget build(BuildContext context) {
    final baseProviderWidgetState = context.watch<LoadingModel>();
    final toast = context.watch<ToastProvider>();
    print('当前弹窗提示  ${toast.isVisible}');
    return Stack(
      children: [
        widget.child,
        if(toast.isVisible)
          Center(
            child: Container(
              // 你可以根据需要调整padding、margin和width
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5), // 灰色半透明背景
                borderRadius: BorderRadius.circular(10.0), // 圆角
              ),
              child: Text(
                toast.message,
                style: const TextStyle(
                  color: Colors.black, // 确保文本颜色与背景色对比鲜明
                  fontSize: 16.0,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  // 根据需要调整字体大小
                ),
                textAlign: TextAlign.center, // 文本居中对齐
              ),
            )
          ),
        if (baseProviderWidgetState.isLoading)
           Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5), // 灰色半透明背景
                  borderRadius: BorderRadius.circular(10.0), // 圆角
                ),
                child: const CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
          ),
      ],
    );
  }
}

class AutoDisappearText extends StatefulWidget {
  final String toastMsg;
  const AutoDisappearText( {super.key, required this.toastMsg});
  @override
  _AutoDisappearTextState createState() => _AutoDisappearTextState();

}

class _AutoDisappearTextState extends State<AutoDisappearText> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    // 1秒后设置_isVisible为false，使文本消失
    Future.delayed(Duration(seconds: 1)).then((_) {
      setState(() {
        _isVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isVisible ? Text(widget.toastMsg) : Container();
  }
}
