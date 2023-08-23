import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/views/polygon/polygon.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:image_picker/image_picker.dart';

import '../../theme.dart';


XFile? image;
class DiseaseView extends StatefulWidget {
  const DiseaseView({
    Key? key,
  }) : super(key: key);

  @override
  State<DiseaseView> createState() => _DiseaseViewState();
}

class _DiseaseViewState extends State<DiseaseView> {
  File? selectedImage;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var auth = Get.put(AuthController());
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Plant Disease Detector",
                        style: h1.copyWith(fontSize: 34, color: Colors.black),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "Please use only\nleaf images",
                        style: sub1,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        "Upload Image",
                        style: sub1.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Pallete.greenColor),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      await chooseImage();
                    },
                    child: selectedImage != null
                        ? Container(
                        width: size.width * 0.84,
                        height: size.height * 0.2,
                        decoration: ShapeDecoration(
                          color: Color(0xFFF4FCF7),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7)),
                          shadows: [
                            BoxShadow(
                              color: Color(0x28000000),
                              blurRadius: 43,
                              offset: Offset(-2, 11),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Image.file(selectedImage!)) // Show the picked image
                        :Container(
                      child: Center(
                        child: IconButton(
                          iconSize: 44,
                          icon: Icon(
                            LineIcons.camera,
                            color: Pallete.greenColor,
                          ),
                          onPressed: () {},
                        ),
                      ),
                      width: size.width * 0.84,
                      height: size.height * 0.2,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF4FCF7),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7)),
                        shadows: [
                          BoxShadow(
                            color: Color(0x28000000),
                            blurRadius: 43,
                            offset: Offset(-2, 11),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Uploading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<bool> chooseImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: MediaQuery.of(context).size.height * 0.1,
              child: Column(
                children: const [
                  Text(
                    'No File choosen',
                  ),
                ],
              ),
            ),
          );
        },
      );
      return false;
    } else {
      setState(() {
        selectedImage = File(pickedFile.path);
      });
      File file = File(pickedFile!.path);
      // uploadFile(file, context, progController, id);
      return true;
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}