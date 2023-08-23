import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/theme.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    var auth = Get.put(AuthController());
    var size = MediaQuery.of(context).size;
    return Container(
      color: Pallete.backgroundColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Pallete.whiteColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/login_page_gif.gif'),
              Container(),
              const Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:  EdgeInsets.only(left: size.width * 0.1),
                  child: SizedBox(
                    height: size.height * 0.2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: sub1,
                        ),
                        Text(
                          'You have been missed!',
                          style: h1,
                        ),
                        Text(
                          'Login to explore options',
                          style: h1,
                        ),
                        const Spacer(),
                        
                      ],
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Pallete.greenColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size(size.width * 0.7, size.height * 0.07),
                        ),
                        onPressed: (){
                          auth.signInWithGoogle(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/google_icon.png', height: 20, width: 20,	),

                            const Text('Login with Google', style: TextStyle(fontWeight: FontWeight.bold),),

                          ],
                        ),
                      ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}