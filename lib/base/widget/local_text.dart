import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:paopao_accounting/base/model/local_model.dart';

class LocalizedText extends StatelessWidget {
  final String contentKey;
  final TextStyle textStyle;

  const LocalizedText({super.key, required this.contentKey, required this.textStyle,});

  @override
  Widget build(BuildContext context) {
    final languageModel = Provider.of<LocalModel>(context);
    final text = languageModel.getText(contentKey);
    return Text(text,style: textStyle);
  }
}