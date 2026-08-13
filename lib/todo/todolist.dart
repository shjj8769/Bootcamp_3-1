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
  late bool doneValue;
  late DateTime date;
  late String selectedDatePick;
  late List<bool> completeToDoList;

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
    for(int i = 0; i < Message.todoList.length; i++){
      if(Message.todoList[i].todoDate == selectedDatePick){
        dayToDoList.add(Message.todoList[i]);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedDatePick),
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
      body: Center(
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
              height: 650,
              child: ListView.builder(
                itemCount: dayToDoList.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    direction: DismissDirection.endToStart,
                    key: ValueKey(dayToDoList[index]),
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      Get.snackbar(
                        '',
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
                                      fontStyle: dayToDoList[index].todoValue ? FontStyle.italic : FontStyle.normal
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
                                      color: dayToDoList[index].todoValue ? Colors.grey : Color(0xFF8EA2E9)
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
                      await Get.to(Todoadd());
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
    void datePick() async{
    int firstYear = date.year;
    int lastYear = firstYear + 1;

    final selectedDate = await showDatePicker(
      context: context, 
      firstDate: DateTime(firstYear), 
      lastDate: DateTime(lastYear),
    );
    if(selectedDate !=  null){
      selectedDatePick = '${selectedDate.toString().substring(0,10)}';
    }
    setState(() {});
  }
}