import 'package:bootcamp_3_1/model/to_do.dart';
import 'package:bootcamp_3_1/util/message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';

class Todoadd extends StatefulWidget {
  const Todoadd({super.key});

  @override
  State<Todoadd> createState() => _TodoaddState();
}

class _TodoaddState extends State<Todoadd> {
  // Property
  late TextEditingController titleController; // 할 일 이름
  late DateTime date;                         // 날짜
  late bool checkboxValue;                    // 중요 선택
  late String selectedValue;                  // 일상/업무/건강 선택
  late String selectedTime;                   // 사용자가 선택한 시간
  late String selectedDatePick;               // 사용자가 선택한 날짜
  late String selectedMunute;                 // 사용자가 선택한 분

  final List<String> categories = ['일상', '업무', '건강'];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    selectedDatePick = DateTime.now().
    toString().substring(0, 10);
    checkboxValue = false;
    selectedValue = '일상'; // 일상/업무/건강 중 초기 값 설정
    date = DateTime.now();
    selectedTime = '';
    selectedMunute = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('할 일 추가'),
        backgroundColor: Color(0xFF8EA2E9),
        foregroundColor: Color(0xFFF4F7FF),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: titleController,
                textAlign: TextAlign.start,
                maxLength: 20,
                decoration: InputDecoration(
                  hintText: '할 일을 입력하세요.'
                ),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                datePick();
              }, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A5DBB),
                foregroundColor: Color(0xFFF4F7FF)
              ),
              child: Text('날짜 선택')
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                selectedDatePick,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text(
              '시간 선택',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 200,
              // 시간 선택 기능 구현
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                minuteInterval: 1,
                use24hFormat: false,
                initialDateTime: DateTime.now(),
                onDateTimeChanged: (DateTime selectedDatetime) {
                  setState(() {});
                  selectedTime = selectedDatetime.hour.toString().padLeft(2,'0');
                  selectedMunute = selectedDatetime.minute.toString().padLeft(2,'0');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 일상/업무/건강 선택 가능한 dropdownbutton구현
                  DropdownButton<String>(
                    value: selectedValue,
                    items: ['일상', '업무', '건강'].map((String value) {
                      return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                    if (newValue != null) {
                      selectedValue = newValue; 
                      setState(() {});
                    }
                  },
                ),
                  Text(
                    '       중요',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                    ),
                    // 중요도 선택 가능한 체크 박스 생성
                  Checkbox(
                    value: checkboxValue, 
                    onChanged: (value){
                      checkboxValue = !checkboxValue;
                      setState(() {});
                    }
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
                // 할 일 제목 미기입 시 스낵바 출력
                if(titleController.text.trim().isEmpty){
                  Get.snackbar(
                    '',
                    '',
                    titleText: Text(
                      '경고',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ), 
                    messageText: Text(
                      '할 일을 입력하세요.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: Colors.red,
                    snackPosition: SnackPosition.BOTTOM,
                    duration: Duration(seconds: 2),
                  );
                }
                else{
                  // 정상 기입 시 todolist에 할 일 목록추가
                  addToDoList();
                  Get.back();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF4A5DBB),
                foregroundColor: Color(0xFFF4F7FF)
              ),
              child: Text('추가하기'),
            )
          ],
        ),
      ),
    );
  }

  //--------Functions
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

  void addToDoList(){
    Message.todoList.add(ToDo(
      todoDate: selectedDatePick, 
      todoText: selectedValue, 
      todoTitle: titleController.text.trim(), 
      todoIcon: Icon(
                  Icons.star,
                  color: checkboxValue ? Color(0xFF8EA2E9) : Color(0xFFF4F7FF), // 중요 선택 안할 시 별이 안보이도록 설정
                ),
      todoValue: false, // todoValue : 완료 or 미완료 기입이기 때문에 초기값을 false로 설정 -> 이후 todolist.dart에서 설정 가능
      todoTime: '$selectedTime : $selectedMunute', // 시간과 분을 따로 저장해서 출력
      )
    );
    setState(() {});
  }
}