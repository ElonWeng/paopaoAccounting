// 示例的隐私政策页面
import 'package:flutter/material.dart';
import 'package:paopao_accounting/base/util/shared_preferences_util.dart';

import 'configs.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({super.key});

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  final _hostController = TextEditingController(text: Configs.host);
  final _portController = TextEditingController(text: Configs.port);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('环境配置'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () async {
                  await SharedPreferencesUtil.setString(Configs.key_host_port,
                          '${_hostController.text},${_portController.text}')
                      .then((_) {
                        Configs.host = _hostController.text;
                        Configs.port = _portController.text;
                        Navigator.of(context).pop();
                  });
                },
                child: const Text(
                  "保存",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              TextField(
                controller: _hostController,
                decoration: const InputDecoration(
                  hintText: '请输入域名',
                ),
              ),
              TextField(
                controller: _portController,
                decoration: const InputDecoration(hintText: '请输入端口号'),
              )
            ],
          ),
        ));
  }
}
