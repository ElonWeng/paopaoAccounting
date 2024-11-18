import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:paopao_accounting/base/config/config_page.dart';
import 'package:paopao_accounting/base/config/navigator_key.dart';
import 'package:paopao_accounting/base/config/routes.dart';
import 'package:paopao_accounting/base/model/loading_model.dart';
import 'package:paopao_accounting/base/model/local_model.dart';
import 'package:paopao_accounting/base/store/login_store.dart';
import 'package:paopao_accounting/base/util/routes_util.dart';
import 'package:paopao_accounting/base/util/shared_preferences_util.dart';
import 'package:paopao_accounting/base/widget/input_bg.dart';
import 'package:paopao_accounting/base/widget/local_text.dart';
import 'package:paopao_accounting/ui/login/login_model.dart';
import 'package:paopao_accounting/ui/login/privacypolicy_page.dart';
import 'package:paopao_accounting/ui/login/serviceterms_page.dart';

import '../../base/config/configs.dart';
import '../../base/config/text_size_key.dart';
import '../../base/model/font_size_model.dart';
import '../../base/model/toast_provider.dart';
import '../../base/util/check_util.dart';
import '../../net/dio_manger.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  LoginModel loginModel = LoginModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<LocalModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Image.asset(
                  'assets/images/icon_internation.png',
                  width: 20,
                  height: 20,
                ),
                onTap: () {
                  languageModel.locale =
                      languageModel.locale.languageCode == 'en'
                          ? const Locale('zh', '') // 切换到中文
                          : const Locale('en', ''); // 切换到英文
                  print('当前语言包${languageModel.locale.languageCode}');
                  Configs.language = languageModel.locale.languageCode;
                  SharedPreferencesUtil.setString(
                          Configs.key_global, languageModel.locale.languageCode)
                      .then((_) {});
                },
              )
            ],
          ), // 根据需要自定义标题
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    if (!CheckUtil.isRelease()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ConfigPage()),
                      );
                    }
                  },
                  child:  Text(
                    '589.AI',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Provider.of<FontSizeModel>(context, listen: false)
                            .getTextSize(TextSizeKey.logoTitleSize),
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 50), // 垂直间距
                LocalizedText(
                  contentKey: 'create',
                  textStyle: TextStyle(
                      fontSize:
                          Provider.of<FontSizeModel>(context, listen: false)
                              .getTextSize(TextSizeKey.bigTitleSize),
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10), // 垂直间距
                LocalizedText(
                    contentKey: 'emailTitle',
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize:
                            Provider.of<FontSizeModel>(context, listen: false)
                                .getTextSize(TextSizeKey.titleSize))),
                const SizedBox(height: 20), // 垂直间距
                /*email输入框*/
                InputBgWidget(
                    child: Center(
                  child: TextField(
                    controller: _emailController,
                    decoration:  InputDecoration(
                      hintText: 'email@domain.com',
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.normal, color: Colors.grey,
                      fontSize: Provider.of<FontSizeModel>(context, listen: false)
                          .getTextSize(TextSizeKey.titleSize)),
                      border: InputBorder.none,
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                    ),
                  ),
                )),
                const SizedBox(height: 15), // 垂直间距
                InkWell(
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.black,
                    ),
                    child: Center(
                      child: LocalizedText(
                        contentKey: 'sighUp',
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: Provider.of<FontSizeModel>(context,
                                    listen: false)
                                .getTextSize(TextSizeKey.titleSize)),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (loginModel.checkEmail(_emailController.text)) {
                      //获取验证码
                      context.read<LoadingModel>().show();
                      LoginStore.sendEmailCode(_emailController.text)
                          .then((value) {
                        if (value[DioManger.success]) {
                          context.read<LoadingModel>().hide();
                          RoutesUtil.navigateToPage(context,CODE_PAGE,
                              {NavigatorKey.keyEmail: _emailController.text});
                        } else {
                          context.read<LoadingModel>().hide();
                          Provider.of<ToastProvider>(context, listen: false)
                              .showToast(value[DioManger.msg]);
                        }
                      });
                    } else {
                      Provider.of<ToastProvider>(context, listen: false)
                          .showToast(
                              Provider.of<LocalModel>(context, listen: false)
                                  .getText('emailInput'));
                    }
                  },
                ),
                const SizedBox(height: 20), // 垂直间距
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LocalizedText(
                        contentKey: 'or',
                        textStyle: TextStyle(
                            fontSize: Provider.of<FontSizeModel>(context,
                                    listen: false)
                                .getTextSize(TextSizeKey.titleSize)))
                  ],
                ),
                const SizedBox(height: 20), // 垂直间距
                InkWell(
                  child: Container(
                    height: 50,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: Colors.black12),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/icon_google.png',
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          context.watch<LoginModel>().getText(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: Provider.of<FontSizeModel>(context,
                                      listen: false)
                                  .getTextSize(TextSizeKey.titleSize)),
                        ),
                      ],
                    )),
                  ),
                  onTap: () {
                  },
                ),
                const SizedBox(height: 20), // 垂直间距
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: Provider.of<LocalModel>(context, listen: false)
                            .getText('agree'),
                        style: TextStyle(
                            fontSize: Provider.of<FontSizeModel>(context,
                                    listen: false)
                                .getTextSize(TextSizeKey.contentSize),
                            color: Colors.grey[500])),
                    TextSpan(
                      text: Provider.of<LocalModel>(context, listen: false)
                          .getText('service'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // 跳转到服务条款页面的逻辑
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ServiceTermsPage()),
                          );
                        },
                    ),
                    TextSpan(
                        text: Provider.of<LocalModel>(context, listen: false)
                            .getText('and'),
                        style: TextStyle(
                            fontSize: Provider.of<FontSizeModel>(context,
                                    listen: false)
                                .getTextSize(TextSizeKey.contentSize),
                            color: Colors.grey[500])),
                    TextSpan(
                      text: Provider.of<LocalModel>(context, listen: false)
                          .getText('privacy'),
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // 跳转到隐私政策页面的逻辑
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PrivacyPolicyPage()),
                          );
                        },
                    ),
                  ],
                ))
              ],
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
