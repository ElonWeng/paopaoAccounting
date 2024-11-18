import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paopao_accounting/base/config/language_key.dart';
import 'package:paopao_accounting/base/config/routes.dart';
import 'package:paopao_accounting/base/config/text_size_key.dart';
import 'package:paopao_accounting/base/model/font_size_model.dart';
import 'package:paopao_accounting/base/model/loading_model.dart';
import 'package:paopao_accounting/base/model/local_model.dart';
import 'package:paopao_accounting/base/store/login_store.dart';
import 'package:paopao_accounting/base/widget/box_bg.dart';
import 'package:paopao_accounting/base/widget/base_page.dart';
import 'package:paopao_accounting/base/widget/local_text.dart';
import 'package:paopao_accounting/ui/login/login_model.dart';
import '../../base/config/navigator_key.dart';
import '../../base/model/time_model.dart';
import '../../base/model/toast_provider.dart';
import '../../base/util/routes_util.dart';
import '../../base/widget/input_bg.dart';
import '../../net/dio_manger.dart';

class CodePage extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const CodePage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<CodePage> createState() => _CodePageState();
}

class _CodePageState extends State<CodePage> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _codeOneController = TextEditingController();
  final TextEditingController _codeTwoController = TextEditingController();
  final TextEditingController _codeThreeController = TextEditingController();
  final TextEditingController _codeFourController = TextEditingController();
  final TextEditingController _codeFiveController = TextEditingController();
  final TextEditingController _codeSixController = TextEditingController();

  LoginModel loginModel = LoginModel();

  @override
  void initState() {
    super.initState();
    context.read<TimerModel>().startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: LocalizedText(
                  contentKey: LanguageKey.strCodeNext,
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize:
                          Provider.of<FontSizeModel>(context, listen: false)
                              .getTextSize(TextSizeKey.titleSize)),
                ),
                onTap: () {
                  RoutesUtil.navigateToPage(context,MAIN_PAGE,
                      {NavigatorKey.keyMainPage: ''});
                  return;
                  if(_codeController.text.isNotEmpty){
                    context.read<LoadingModel>().show();
                    LoginStore.login(widget.arguments[NavigatorKey.keyEmail], _codeController.text).then((value){
                      context.read<LoadingModel>().hide();
                      if(value[DioManger.success]){
                        Provider.of<ToastProvider>(context, listen: false)
                            .showToast(Provider.of<LocalModel>(context, listen: false).getText(LanguageKey.strSuccess));
                      }else{
                        Provider.of<ToastProvider>(context, listen: false)
                            .showToast(value[DioManger.msg]);
                      }
                    });
                  }else{
                    Provider.of<ToastProvider>(context, listen: false)
                        .showToast(
                        Provider.of<LocalModel>(context, listen: false)
                            .getText(LanguageKey.strCodeInput));
                  }
                },
              )
            ],
          ),
        ),
        body: BaseProviderWidget(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Consumer<TimerModel>(
                builder: (context, model, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10), // 垂直间距
                      LocalizedText(
                        contentKey: LanguageKey.strCodeInput,
                        textStyle: TextStyle(
                            fontSize: Provider.of<FontSizeModel>(context,
                                    listen: false)
                                .getTextSize(TextSizeKey.bigTitleSize),
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10), // 垂直间距
                      RichText(
                          text: TextSpan(
                        children: [
                          TextSpan(
                              text: Provider.of<LocalModel>(context,
                                      listen: false)
                                  .getText(LanguageKey.strCodeInputContent),
                              style: TextStyle(
                                  fontSize: Provider.of<FontSizeModel>(context,
                                          listen: false)
                                      .getTextSize(TextSizeKey.contentSize),
                                  color: Colors.grey[500])),
                          TextSpan(
                            text: widget.arguments[NavigatorKey.keyEmail].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                color: Colors.black),
                          ),
                        ],
                      )),
                      const SizedBox(height: 20), // 垂直间距
                      //格子的验证码 先保留
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: BoxBgWidget(
                      //         height: 50,
                      //         width: 50,
                      //         editingController: _codeOneController,
                      //       ),
                      //     ),
                      //     const SizedBox(width: 15),
                      //     Expanded(
                      //       child: BoxBgWidget(
                      //         height: 50,
                      //         width: 50,
                      //         editingController: _codeTwoController,
                      //       ),
                      //     ),
                      //     const SizedBox(width: 15),
                      //     Expanded(
                      //       child: BoxBgWidget(
                      //         height: 50,
                      //         width: 50,
                      //         editingController: _codeThreeController,
                      //       ),
                      //     ),
                      //     const SizedBox(width: 15),
                      //     Expanded(
                      //         child: BoxBgWidget(
                      //       height: 50,
                      //       width: 50,
                      //       editingController: _codeFourController,
                      //     )),
                      //     const SizedBox(width: 15),
                      //     Expanded(
                      //         child: BoxBgWidget(
                      //       height: 50,
                      //       width: 50,
                      //       editingController: _codeFiveController,
                      //     )),
                      //     const SizedBox(width: 15),
                      //     Expanded(
                      //         child: BoxBgWidget(
                      //       height: 50,
                      //       width: 50,
                      //       editingController: _codeSixController,
                      //     )),
                      //   ],
                      // ),
                      InputBgWidget(
                          child: Center(
                        child: TextField(
                          controller: _codeController,
                          decoration: const InputDecoration(
                            hintText: '',
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.grey),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 15),
                          ),
                        ),
                      )),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: LocalizedText(
                              contentKey: LanguageKey.strCodeGet,
                              textStyle: TextStyle(
                                  fontSize: Provider.of<FontSizeModel>(context,
                                          listen: false)
                                      .getTextSize(TextSizeKey.contentSize)),
                            ),
                            onTap: () {
                              if (model.remainingTime == 0) {
                                context.read<LoadingModel>().show();
                                LoginStore.sendEmailCode(
                                        widget.arguments[NavigatorKey.keyEmail])
                                    .then((value) {
                                  context.read<LoadingModel>().hide();
                                  if (value[DioManger.success]) {
                                    context.read<TimerModel>().startTimer();
                                    Provider.of<ToastProvider>(context, listen: false)
                                        .showToast(Provider.of<LocalModel>(context, listen: false).getText(LanguageKey.strSuccess));
                                  } else {
                                    Provider.of<ToastProvider>(context,
                                            listen: false)
                                        .showToast(value[DioManger.msg]);
                                  }
                                });
                              } else {
                                Provider.of<ToastProvider>(context,
                                        listen: false)
                                    .showToast(Provider.of<LocalModel>(context,
                                            listen: false)
                                        .getText(LanguageKey.strCodeGetWait));
                              }
                            },
                          ),
                          InkWell(
                            child: Text(model.remainingTime == 0
                                ? Provider.of<LocalModel>(context,
                                        listen: false)
                                    .getText(LanguageKey.strCodeGetAgain)
                                : '${model.remainingTime}s'),
                            onTap: () {
                              if (model.remainingTime == 0) {
                                context.read<LoadingModel>().show();
                                LoginStore.sendEmailCode(
                                        widget.arguments[NavigatorKey.keyEmail])
                                    .then((value) {
                                  context.read<LoadingModel>().hide();
                                  if (value[DioManger.success]) {
                                    context.read<TimerModel>().startTimer();
                                    Provider.of<ToastProvider>(context, listen: false)
                                        .showToast(Provider.of<LocalModel>(context, listen: false).getText(LanguageKey.strSuccess));
                                  } else {
                                    Provider.of<ToastProvider>(context,
                                            listen: false)
                                        .showToast(value[DioManger.msg]);
                                  }
                                });
                              }
                            },
                          )
                        ],
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }
}
