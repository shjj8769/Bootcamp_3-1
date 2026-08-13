import 'package:flutter/material.dart';

class Planer {
  final IconData iconList;  // 아이콘
  final String todoList;    // 할 일
  final String plusList;    // 실시간 현황


  Planer(
    {
      required this.iconList,
      required this.todoList,
      required this.plusList,
    }
  );
}