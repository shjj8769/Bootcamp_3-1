import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  // Property
  XFile? imageFile;
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if(imageFile == null)
            IconButton(
              onPressed: (){
                getImageFromDevice(ImageSource.camera);
              }, 
              icon: Icon(
                Icons.camera_alt_outlined,
                size: 70,
                color: Colors.white,
              ),
            ),
              SizedBox(
              width: MediaQuery.of(context).size.width, // 휴대폰의 사이즈를 알려준다.
              child: Center(
                child: imageFile == null
                  ? Text(
                    '화면을 눌러 카메라를 실행하세요.',
                  style: TextStyle(color: Colors.white),)
                  : Image.file(File(imageFile!.path)) // 스마트폰에 있는 파일은 파일로 불러온다. // 해당 파일의 경로만 가져온다.
                ,                                     // X파일의 형태로 파일로 가져온다.
              ),
            ),
          ],
        ),
      ),
    );
  } // build

  // ------ Function -------
    void getImageFromDevice(ImageSource imageSource)async{
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if(pickedFile == null){
      imageFile = null;
    }else{
      imageFile = XFile(pickedFile.path);
    }
    setState(() {});
  }

} // class