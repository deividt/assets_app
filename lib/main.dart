import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'assets_app.dart';
import 'constants/urls.dart';
import 'global_provider.dart';
import 'services/dio/dio_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  final dioService = await DioService().setup(
    baseUrl: Urls.apiBaseUrl,
  );

  runApp(
    GlobalProvider(
      dio: dioService,
      child: const AssetsApp(),
    ),
  );
}
