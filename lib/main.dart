import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ALL INIT
import 'package:harp_flutter/plugins/initialApp.dart';
import 'package:harp_flutter/routers.dart';
import 'package:harp_flutter/store/index.dart';

Future<void> main() async {
  InitialApp().start(); // INIT PLUGINS
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final StoreX storex = Get.put(StoreX()); 
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: '_title',
        // theme: ThemeData(fontFamily: "Roboto", primarySwatch: Colors.blue),
        theme: storex.themes['type']!  ? ThemeData(brightness: Brightness.light,
        ):ThemeData(fontFamily: "Roboto", primarySwatch: Colors.blue),
        darkTheme: storex.themes['type']! ? ThemeData(
          brightness: Brightness.dark,
        ):ThemeData(
          brightness: Brightness.light,
        ),
        themeMode: storex.themes['type']! ? ThemeMode.dark:ThemeMode.light, 
        // ========================= ROUTE ==============================
        initialRoute: '/',
        routes: routers(),
      );
  }
}

