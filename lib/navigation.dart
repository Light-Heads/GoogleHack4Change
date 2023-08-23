import 'package:flutter/material.dart';
import 'package:frontend/auth/form.dart';
import 'package:frontend/auth/roles.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'controllers/nav_controller.dart';


class Navigation extends StatelessWidget {
  final controller = Get.put(NavigationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (controller) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                Container(
                  color: Colors.red,
                ),
                Container(
                  color: Colors.blue,
                ),
                FormView(),
                RoleSelectionScreen(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
                child: GNav(
                  onTabChange: controller.changeTabIndex,
                  gap: 8,
                  activeColor: Colors.white,
                  iconSize: 24,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  duration: const Duration(milliseconds: 500),
                  tabBackgroundColor: Colors.green,
                  color: Colors.black38,
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: 'Home',
                      // textStyle: resourceStyle,
                    ),
                    GButton(
                      icon: LineIcons.pollH,
                      text: 'Network',
                      // textStyle: resourceStyle,
                    ),
                    GButton(
                      icon: LineIcons.bell,
                      text: 'Reminders',
                      // textStyle: resourceStyle,
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Profile',
                      // textStyle: resourceStyle,
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }
}
