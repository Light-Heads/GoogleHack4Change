import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/pallete.dart';
import 'package:line_icons/line_icons.dart';

import '../core/buttons.dart';
import '../theme.dart';
import 'package:image_picker/image_picker.dart';
class FormView extends StatefulWidget {
  final int roleid;
  const FormView({Key? key, required this.roleid,}) : super(key: key);
  

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 28.0, top: 20),
                      child: IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back, size: 30,color: Colors.black,),
                      )
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Few More Steps", style: h1.copyWith(fontSize: 34, color: Colors.black),),
                      Text("Your data helps us stay\nconnected", style: sub1,),
                      SizedBox(height: size.height*0.03,),
                      Text("Upload your profile picture", style: sub1.copyWith(fontSize: 16, fontWeight: FontWeight.w800, color: Pallete.greenColor),),
                    ],
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () async {
                      await chooseImage();
                    },
                    child: Container(
                      child: Center(
                        child: IconButton(
                          iconSize: 44,
                          icon: Icon(LineIcons.camera,color: Pallete.greenColor,), onPressed: () {  },
                        ),
                      ),
                      width: size.width*0.84,
                      height: size.height*0.2,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF4FCF7),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
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
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Enter your full name", style: sub1.copyWith(fontSize: 16, fontWeight: FontWeight.w800, color: Pallete.greenColor),),
                      SizedBox(height: size.height*0.02,),
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          focusColor: Pallete.greenColor,
                          fillColor: Pallete.greenColor,

                          labelText: 'Full Name',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                          ),
                        ),
                      ),
                      SizedBox(height: size.height*0.02,),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: _phoneController,
                        validator: PhoneNumberValidator.validate,
                        decoration: InputDecoration(
                          focusColor: Pallete.greenColor,
                          fillColor: Pallete.greenColor,

                          labelText: 'Phone Number',
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height*0.02,),


                Align(
                  alignment: Alignment.center,
                    child: InkWell(
                      onTap: (){},
                        child: Button(size, "Next"))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Uploading..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  Future<bool> chooseImage() async {

    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

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

class PhoneNumberValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    final cleanedValue = value.replaceAll(RegExp(r'\D'), '');

    if (cleanedValue.length < 10) {
      return 'Phone number must be at least 10 digits';
    }

    return null; // Validation passed
  }
}


