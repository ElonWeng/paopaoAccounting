// navigation_service.dart
import 'package:flutter/material.dart';

import '../config/routes.dart';

class RoutesUtil {
  static void navigateToPage(BuildContext context, String pageName, Map<String, dynamic> params) {
    Navigator.of(context).pushNamed(
      pageName,
      arguments: params,
    );
  }

}