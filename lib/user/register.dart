import 'package:bootcamp_3_1/user/login_page.dart';
import 'package:bootcamp_3_1/util/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  //Property
  late TextEditingController idController;
  late TextEditingController pwController;
  late TextEditingController pwCheckController;

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    pwController = TextEditingController();
    pwCheckController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F4FA),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "회원가입",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4A5DBB)
              ),
            ),
            const SizedBox(height: 40,),
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
              const SizedBox(height: 18),
              TextField(
                controller: pwCheckController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: '비밀번호를 다시한번 입력하세요',
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 100,),
              // ---- 회원가입 버튼 ----
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if(idController.text.trim().isEmpty || pwController.text.trim().isEmpty || pwCheckController.text.trim().isEmpty){
                      checkRegister();
                      return;
                    }
                    bool userId = false;
                    for (int i = 0; i < User.info.userId.length; i++) {
                      if (User.info.userId[i] == idController.text.trim()) {
                        userId = true;
                        break;
                      }
                    }
                    if (userId) {
                      checkSnackBar();
                    } else if (pwController.text.trim() != pwCheckController.text.trim()) {
                      errorSnackBar();
                    } else {
                      checkLogin();
                      User.info.userId.add(idController.text.trim());
                      User.info.userPw.add(pwController.text.trim());
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
                    '회원가입',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  } // Build

  //---Function---

    void checkLogin() {
    Get.defaultDialog(
        title: '환영합니다',
        middleText: '회원가입이 확인되었습니다.',
        barrierDismissible: false,
        actions: [
          TextButton(
            onPressed: () {
              Get.to(LoginPage());
            },
            child: Text('로그인'),
          ),
        ]);
  }

  void checkSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("이미 사용중인 아이디 입니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

  void errorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("비밀번호가 일치하지 않습니다."),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

    void checkRegister() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("아이디와 비밀번호를 입력해주세요"),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ),
    );
  }

} // Class