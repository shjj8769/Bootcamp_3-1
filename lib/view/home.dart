import 'package:bootcamp_3_1/model/planer.dart';
import 'package:bootcamp_3_1/todo/todoadd.dart';
import 'package:bootcamp_3_1/todo/todolist.dart';
import 'package:bootcamp_3_1/user/login_page.dart';
import 'package:bootcamp_3_1/widget/camera.dart';
import 'package:bootcamp_3_1/widget/map_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  final List<Planer> list;
  const Home({super.key, required this.list});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{
  //  Property
  late TextEditingController userNameController;    // 사용자 아이디
  late TabController tabController;                 // TabBar
  late List<Planer> todoList;                       // 할 일 리스트
  late List<IconData> iconList;                     // 아이콘 리스트
  late List<String> plusList;                       // 현재 달성 상태
  late String userName;
  late int achievementValue;                        // 달성률


  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
    tabController = TabController(length: 4, vsync: this);
    userName = "admin";
    achievementValue = 0;
    todoList = [];
    iconList = [];
    plusList = [];
    addList();      // 할 일 리스트 (아이콘 + 텍스트)
  }

  @override
  void dispose() {
    tabController.dispose(); // 화면 종료 시 컨트롤러 해제
    super.dispose();
  }

  void addList(){
    todoList.add(Planer(iconList: Icons.check_circle_outline, todoList: '오늘 할 일', plusList: ' 개 남음'));
    todoList.add(Planer(iconList: Icons.add_circle_outline, todoList: '할 일 추가', plusList: '이번 달  개'));
    todoList.add(Planer(iconList: Icons.location_on_outlined, todoList: '지도 메뉴', plusList: '최근 위치  곳'));
    todoList.add(Planer(iconList: Icons.camera_alt_outlined, todoList: '포토 메뉴', plusList: '신규 등록 가능'));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 30,
                  ),
                  Text(
                    '안녕하세요, $userName님',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
                    Icons.waving_hand_rounded,
                    color: Colors.amber
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 170, 0),
                child: Text(
                  '오늘도 한 걸음 가벼운 하루를 설계해보세요',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF4A5DBB),
                  borderRadius: BorderRadius.circular(12)
                ),
                child: SizedBox(
                  width: 360,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '오늘의 할 일 달성률 ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF4F7FF)
                        ),
                      ),
                      Text(
                        '   $achievementValue%',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF4F7FF)
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 10), // 왼쪽 정렬 정돈
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    '바로가기',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.builder(
                    itemCount: todoList.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ), 
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          switch(index) {
                            case 0:
                            setState(() {});
                            Get.to(Todolist());
                            break;

                            case 1:
                            Get.to(Todoadd());
                            break;

                            case 2:
                            setState(() {});
                            Get.to(MapPage());
                            break;

                            case 3:
                            setState(() {});
                            Get.to(Camera());
                            break;
                          }
                        },
                        child: Card(
                          color: const Color(0xFFF4F7FF),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  todoList[index].iconList,
                                  color: const Color(0xFF4A5DBB),
                                  size: 35,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  todoList[index].todoList,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  todoList[index].plusList,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ) // <<<<<<<<<<<<<<<<<<<<<<<< 받을공간
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          
          // [두 번째 탭]: 오늘 할 일 진짜 페이지
          Todolist(),
          
          // [세 번째 탭]: 지도 페이지
          MapPage(),
          
          // [네 번째 탭]: 카메라 페이지
          Camera(),
        ], // TabBarView
      ), // TabBarView 끝
      
      // Scaffold 앞에
      bottomNavigationBar: Container(
        color: Colors.white,
        child: TabBar(
          controller: tabController,
          labelColor: const Color(0xFF4A5DBB),
          unselectedLabelColor: Colors.grey,
          indicatorColor: const Color(0xFF4A5DBB),
          tabs: const [
            Tab(
              icon: Icon(Icons.home_outlined),
              text: '홈',
            ),
            Tab(
              icon: Icon(Icons.check_circle_outline),
              text: '할일',
            ),
            Tab(
              icon: Icon(Icons.location_on_outlined),
              text: '지도',
            ),
            Tab(
              icon: Icon(Icons.camera_alt_outlined),
              text: '카메라',
            ),
          ],
        ),
      ),
    );
  }
}
