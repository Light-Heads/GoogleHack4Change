import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:frontend/controllers/nav_controller.dart';

import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/pallete.dart';

import 'package:frontend/views/chat/views/global_chat.dart';
import 'package:frontend/views/home/homepage.dart';
import 'package:frontend/views/polygon/loader.dart';
import 'package:frontend/views/user/profile.dart';

import 'package:get/get.dart';

import 'package:line_icons/line_icons.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}



class _NavigationState extends State<Navigation> {
  final controller = Get.put(NavigationController());
  final user = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    
    var pages = [
      const Homepage(),
      const MobileChatScreen(),
      const ProfileScreen(),
      // const StatsScreenWidget(),
      //  ChattingScreen()
    ];
    var BottomNavBarItems = [
      const BottomNavigationBarItem(
        icon: Icon(OctIcons.home_fill_24),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        backgroundColor: Colors.white,
        icon: Icon(OctIcons.comment_16),
        label: 'Chat',
      ),
      const BottomNavigationBarItem(
        icon: Icon(OctIcons.person_16),
        label: 'Train',
      ),
    ];
    return GetBuilder<NavigationController>(builder: (controller) {
      var size = MediaQuery.of(context).size;
      return Scaffold(
        // backgroundColor: Colors.white,
        extendBody: true,
        body: SafeArea(
          child: Scaffold(
              extendBody: true,
              resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  pages[controller.tabIndex],
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: size.height * 0.02,
                          left: size.width * 0.08,
                          right: size.width * 0.08),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 20,
                              spreadRadius: 1,
                              offset: const Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                          ),
                          color: Pallete.whiteColor,
                        ),
                        height: size.height * 0.07,
                        width: size.width,
                        child: BottomNavigationBar(
                          type: BottomNavigationBarType.fixed,
                          backgroundColor: Colors.transparent,
                          currentIndex: controller.tabIndex,
                          elevation: 1000,
                          selectedIconTheme: const IconThemeData(
                            size: 25,
                          ),
                          selectedItemColor: Colors.black87,
                          unselectedItemColor: Colors.black45,
                          showSelectedLabels: false,
                          showUnselectedLabels: false,
                          onTap: (index) {
                            controller.changeTabIndex(index);
                          },
                          items: BottomNavBarItems,
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ),
      );
    });
  }
}
