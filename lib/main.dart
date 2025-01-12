import 'package:flutter/material.dart';
import 'package:paopao_accounting/ui/login/login_model.dart';
import 'package:paopao_accounting/ui/login/login_page.dart';
import 'package:paopao_accounting/ui/splash/Splash.dart';
import 'package:provider/provider.dart';
import 'base/config/routes.dart';
import 'base/model/font_size_model.dart';
import 'base/model/loading_model.dart';
import 'base/model/local_model.dart';
import 'base/model/time_model.dart';
import 'base/model/toast_provider.dart';
import 'base/util/localization_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en'); // 默认语言

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
      [
        ChangeNotifierProvider(create: (_) => LoginModel()),
        ChangeNotifierProvider(create: (_) => LocalModel()),
        ChangeNotifierProvider(create: (_) => FontSizeModel()),
        ChangeNotifierProvider(create: (_) => LoadingModel()),
        ChangeNotifierProvider(create: (_) => ToastProvider()),
        ChangeNotifierProvider(create: (_) => TimerModel()),
      ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PiPo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      locale: _locale,
      supportedLocales: const [
        Locale('en'), // 英文
        Locale('zh'), // 中文
        Locale('es'), // 西班牙语
      ],
      localizationsDelegates: const [
        LocalizationService.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routes: {
        LOGIN_PAGE: (context) => const LoginPage(),
      },
      home: SplashScreen(
        onLocaleChange: _setLocale, // 向 SplashScreen 传递切换语言函数
      ),
    ),
    );
  }
}
