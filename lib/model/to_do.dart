import 'package:flutter/material.dart';

class ToDo {
  String todoDate; // 날짜
  String todoText; // 일상, 업무, 건강
  String todoTitle; // 할 일 내용
  Icon todoIcon; // 중요 표시시 표기
  bool todoValue; // 완료 확인
  String todoTime; // 시간

  ToDo(
    {
      required this.todoDate,
      required this.todoText,
      required this.todoTitle,
      required this.todoIcon,
      required this.todoValue,
      required this.todoTime,
    }
  );
}