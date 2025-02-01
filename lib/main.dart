import 'package:flutter/material.dart';
import 'package:work_hive_mobile/app/app.dart';
import 'package:work_hive_mobile/app/di/di.dart';
import 'package:work_hive_mobile/core/network/hive_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.init();

  await initDependencies();

  runApp(
    const MyApp(),
  );
}
