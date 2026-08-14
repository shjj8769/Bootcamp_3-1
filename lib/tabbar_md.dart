import 'package:flutter/material.dart';
import 'package:bootcamp_3_1/view/home.dart';          //  내 홈 화면 (알맹이)
import 'package:bootcamp_3_1/todo/todolist.dart';      // 팀원의 할일 페이지
import 'package:bootcamp_3_1/widget/map_page.dart';    // 팀원의 지도 페이지
import 'package:bootcamp_3_1/widget/camera.dart';      // 팀원의 카메라 페이지

class TabbarMd extends StatefulWidget {
  const TabbarMd({super.key});

  @override
  State<TabbarMd> createState() => _TabbarMdState();
}

class _TabbarMdState extends State<TabbarMd> with SingleTickerProviderStateMixin{
  // Property
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: [
          Home(),
          Todolist(),
          MapPage(),
          Camera(),
        ]
      ),
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