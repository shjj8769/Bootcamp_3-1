import 'package:bootcamp_3_1/model/to_do.dart';
import 'package:bootcamp_3_1/todo/todoadd.dart';
import 'package:bootcamp_3_1/util/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Todolist extends StatefulWidget {
  const Todolist({super.key});

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  // Property
  late bool doneValue; // 완료 여부 확인
  late DateTime date;  // 날짜
  late String selectedDatePick; // 선택된 날짜(캘린더 아이콘 클릭 후 설정)
  late List<bool> completeToDoList; // 완료 된 todo목록 리스트 설정

  @override
  void initState() {
    super.initState();
    doneValue = false;
    date = DateTime.now();
    selectedDatePick = DateTime.now().toString().substring(0, 10);
    completeToDoList = [];
  }

  @override
  Widget build(BuildContext context) {
    List<ToDo> dayToDoList = [];
    // 완료한 갯수를 확인하기 위해서 생성
    for(int i = 0; i < Message.todoList.length; i++){
      if(Message.todoList[i].todoDate == selectedDatePick){
        dayToDoList.add(Message.todoList[i]);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedDatePick),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: (){
              datePick();
              setState(() {});
            }, 
            icon: Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF8EA2E9),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.grey,
                ),
                Text(
                  '왼쪽으로 밀어서 할 일을 삭제할 수 있습니다.',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 590,
              child: ListView.builder(
                itemCount: dayToDoList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ValueKey(dayToDoList[index]),
                    background: SizedBox(
                      width: 400,
                      height: 300,
                      child: Card(
                        color: Colors.red,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      // 목록 삭제를 snackBar로 알림
                      Get.snackbar(
                        '', // ''를 2번 설정 하지 않을 시 error -> 공백여부 설정
                        '',
                        titleText: Text(
                          '삭제 완료',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            ),
                          ), 
                        messageText: Text(
                          '${dayToDoList[index].todoTitle}이 삭제 되었습니다.',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.black,
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 2),
                      );
                      // 사용자가 삭제한 번호의 목록을 삭제
                      Message.todoList.remove(dayToDoList[index]);
                      
                      setState(() {});
                    },
                    child: Card(
                      color: Color(0xFFF4F7FF),
                      child: Row(
                        children: [
                          Checkbox(
                            value: dayToDoList[index].todoValue, 
                            onChanged: (value) {
                            // 1. 체크 상태 반전
                              dayToDoList[index].todoValue = !dayToDoList[index].todoValue;
                            // 2. 현재 체크된 개수 세기 (for문 사용)
                              int completeCount = 0;
                              for (int i = 0; i < dayToDoList.length; i++) {
                              if (dayToDoList[i].todoValue) {
                                completeCount++;
                                }
                              }
                            // 3. 퍼센트 계산
                              if (dayToDoList.isNotEmpty) {
                                Message.completePercent = (completeCount / dayToDoList.length) * 100;
                              } else {
                                Message.completePercent = 0;
                                }
                              print('완료율: ${Message.completePercent}%');
                              setState(() {});
                            }
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  dayToDoList[index].todoIcon,
                                  Text(
                                    dayToDoList[index].todoTitle,
                                    style: TextStyle(
                                      // 완료 시 할 일 목록에 취소선
                                      decoration: dayToDoList[index].todoValue ? TextDecoration.lineThrough : TextDecoration.none
                                    ),
                                  ),
                                ]
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(dayToDoList[index].todoTime),
                                  ),
                                  Text(
                                    dayToDoList[index].todoText,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: dayToDoList[index].todoValue ? Colors.grey : Color(0xFF8EA2E9) // 아이콘을 배경색과 동일하게 만들어 사용자가 인식하지 못하지만, 실제로 아이콘은 존재
                                    ),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: IconButton(
                    onPressed: ()async{
                      await Get.to(Todoadd()); // 추가한 목록을 바로 받아오기 위해서 비동기 처리 실행
                      setState(() {});
                    }, 
                    style: IconButton.styleFrom(
                      backgroundColor: Color(0xFF4A5DBB),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(4)
                      )
                    ),
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    )
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  //-------Functions 
    void datePick() async{ // 날짜를 받아오는 함수
    int firstYear = date.year; // 시작 년도 설정
    int lastYear = firstYear + 1; // 사용자가 선택 가능한 최대 년도 설정

    final selectedDate = await showDatePicker(
      context: context, 
      firstDate: DateTime(firstYear), 
      lastDate: DateTime(lastYear),
    );
    if(selectedDate !=  null){
      selectedDatePick = '${selectedDate.toString().substring(0,10)}'; // 불필요한 문자 삭제를 위해 substring()사용
    }
    setState(() {});
  }
}