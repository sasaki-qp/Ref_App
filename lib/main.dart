// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_demo_app/helper/service_locator.dart';
import 'package:hive_demo_app/helper/global_context.dart';
import 'package:hive_demo_app/storage/adapter/user_storage_type.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_demo_app/screens/list_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserStorageTypeAdapter());
  await Hive.openBox<UserStorageType>('box');
  ServiceLocator();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      home: ListScreen(),
    );
  }
}
