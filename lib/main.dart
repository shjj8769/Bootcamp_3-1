import 'package:bootcamp_3_1/tabbar_md.dart';
import 'package:bootcamp_3_1/todo/todolist.dart';
import 'package:bootcamp_3_1/widget/camera.dart';
import 'package:bootcamp_3_1/widget/map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bootcamp_3_1/user/login_page.dart';

import 'view/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}
