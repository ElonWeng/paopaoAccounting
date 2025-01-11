import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LocalizationService {
  final Locale locale;

  LocalizationService(this.locale);

  static LocalizationService of(BuildContext context) {
    return Localizations.of<LocalizationService>(context, LocalizationService)!;
  }

  static Map<String, String> _localizedStrings = {};

  Future<void> load() async {
    String jsonString = await rootBundle
        .loadString('assets/lang/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }

  static const LocalizationsDelegate<LocalizationService> delegate =
  _LocalizationDelegate();
}

class _LocalizationDelegate
    extends LocalizationsDelegate<LocalizationService> {
  const _LocalizationDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'zh', 'es'].contains(locale.languageCode);

  @override
  Future<LocalizationService> load(Locale locale) async {
    LocalizationService localization = LocalizationService(locale);
    await localization.load();
    return localization;
  }

  @override
  bool shouldReload(_LocalizationDelegate old) => false;
}
