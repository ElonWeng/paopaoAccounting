import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'base/util/localization_service.dart';
import 'package:paopao_accounting/ui/splash/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// LocaleProvider 管理语言状态
class LocaleProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); // 默认语言为英文

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'PiPo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
              useMaterial3: true,
            ),
            locale: localeProvider.locale,
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
            home: SplashScreen(
              onLocaleChange: (locale) =>
                  context.read<LocaleProvider>().setLocale(locale), // 切换语言
            ),
          );
        },
      ),
    );
  }
}
