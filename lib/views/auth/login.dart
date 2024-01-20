import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/controllers/language_controller.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/theme.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    return Obx(() => Container(
        color: Pallete.backgroundColor,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Pallete.whiteColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // drop down menu for selecting languages material ui
                      margin: const EdgeInsets.only(top: 20, right: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: DropdownButton<String>(
                        dropdownColor: Color.fromARGB(255, 241, 241, 241),
                        value: Get.find<LanguageController>().value.value,
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        iconSize: size.width * 0.07,
                        elevation: 16,
                        style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                        underline: SizedBox(),
                        onChanged: (String? newValue) {
                          if(newValue == 'English'){
                            Get.find<LanguageController>().updateLocale('en');
                          }
                          else if(newValue == 'हिंदी'){
                            Get.find<LanguageController>().updateLocale('hi');
                          }
                          else if(newValue == 'తెలుగు'){
                            Get.find<LanguageController>().updateLocale('te');
                          }
                        },
                        items: <String>['English', 'हिंदी', 'తెలుగు']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                Image.asset('assets/images/login_page_gif.gif'),
                Container(),
                const Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: size.width * 0.1),
                    child: SizedBox(
                      height: size.height * 0.2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.welcome,
                            style: sub1,
                          ),
                          Text(
                            AppLocalizations.of(context)!.missed,
                            style: h1,
                          ),
                          Text(
                            AppLocalizations.of(context)!.explore,
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
                  onPressed: () {
                    auth.signInWithGoogle(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/google_icon.png',
                        height: 20,
                        width: 20,
                      ),
                      Text(
                        AppLocalizations.of(context)!.buttonLogin,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
