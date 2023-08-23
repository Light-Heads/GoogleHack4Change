import 'package:flutter/material.dart';
import 'package:frontend/pallete.dart';
import 'package:line_icons/line_icons.dart';

import '../core/buttons.dart';
import '../theme.dart';

class FormView extends StatefulWidget {
  const FormView({Key? key}) : super(key: key);

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  TextEditingController _usernameController = TextEditingController();
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
                          // Navigator.pop(context);
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
                    ],
                  ),
                ),
                SizedBox(height: size.height*0.02,),

                Align(
                  alignment: Alignment.center,
                    child: InkWell(
                        child: Button(size, "Next"))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }
}
