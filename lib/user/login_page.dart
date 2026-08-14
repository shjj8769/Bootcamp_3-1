import 'package:bootcamp_3_1/tabbar_md.dart';
import 'package:bootcamp_3_1/todo/todolist.dart';
import 'package:bootcamp_3_1/user/register.dart';
import 'package:bootcamp_3_1/util/user.dart';
import 'package:bootcamp_3_1/view/home.dart';
import 'package:bootcamp_3_1/util/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Property
  late TextEditingController idController;
  late TextEditingController pwController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextButton(
                  onPressed: () {
                    //
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFEDE9FE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
                  ),
                  child: const Text(
                    'HARU PLAN',
                    style: TextStyle(
                      color: Color(0xFF4A5DBB),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              '반가워요!\n오늘도 한 걸음 더',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '하루플랜과 함께 정돈된 하루를 설계해보세요',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 36),
            // ---- 아이디 ----
            const Text(
              '아이디',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: idController,
              decoration: InputDecoration(
                hintText: '아이디를 입력하세요',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 18),
            // ---- 비밀번호 ----
            const Text(
              '비밀번호',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 6),
            TextField(
              controller: pwController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: '비밀번호를 입력하세요',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '비밀번호를 잊으셨나요?',
              style: TextStyle(color: Colors.grey, fontSize: 11),
            ),
            const Spacer(),
            // ---- 로그인 버튼 ----
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (idController.text.trim().isEmpty || pwController.text.trim().isEmpty) {
                    errorSnackBar();
                  }
                  bool userinfo = false;
                  for (int i = 0; i < User.info.userId.length; i++) {
                    if (User.info.userId[i] == idController.text.trim() &&
                        User.info.userPw[i] == pwController.text.trim()) {
                          User.userNum = i;
                          userinfo = true;
                          break;
                    }
                  }
                  if(userinfo){
                    checkLogin();
                  }else{
                    checkSnackBar();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  '로그인',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '아직 회원이 아니신가요? ',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(Register());
                    },
                    child: const Text(
                      '회원가입',
                      style: TextStyle(
                        color: Color(0xFF4F46E5),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  } // Build

  //---Function---

  void checkLogin() {
    Get.defaultDialog(
        title: '반갑습니다',
        middleText: '확인되었습니다.',
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () {
              Get.to(TabbarMd());
            },
            child: Text('확인'),
          ),
        ]);
  }

  void checkSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("사용자 ID나 암호가 올바르지 않습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void errorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("사용자의 아이디와 비밀번호를 모두 입력하세요"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }
} // Class