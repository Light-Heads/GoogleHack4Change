import 'package:flutter/material.dart';
import 'package:frontend/auth/form.dart';
import 'package:frontend/auth/roles.dart';
import 'package:frontend/controllers/polygon_controller.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/views/chat/views/global_chat.dart';
import 'package:frontend/views/classifier/disease.dart';
import 'package:frontend/views/commodity/commodityview.dart';
import 'package:frontend/views/home/homepage.dart';
import 'package:frontend/views/polygon/polygon.dart';

import 'package:frontend/views/user/profile.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'controllers/nav_controller.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final controller = Get.put(NavigationController());
  final polygon = Get.put(PolygonController());
  final user = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NavigationController>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              FutureBuilder(
                future: polygon.getData(user.user.value.polygonId.toString()),
                builder: (context, snapshot) {
                  return Homepage();
                },
              ),
              DiseaseView(),
              CommodityView(),
              ProfileScreen(),
              MobileChatScreen(),
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
              ),
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
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.pollH,
                    text: 'Detector',
                  ),
                  GButton(
                    icon: LineIcons.lineChart,
                    text: 'Market',
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                  ),
                  GButton(icon: LineIcons.chair, text: 'Chat',)
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}


// class Navigation extends StatelessWidget {
//   final controller = Get.put(NavigationController());
//   final polygon = Get.put(PolygonController());
//   final user = Get.put(UserController());
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<NavigationController>(builder: (controller) {
//       return Scaffold(
//         backgroundColor: Colors.white,
//         body: SafeArea(
//           child: IndexedStack(
//             index: controller.tabIndex,
//             children: [
//               FutureBuilder(
//                 future: polygon.getData(user.user.value.polygonId.toString()),
//                 builder: (context, snapshot) {
//                   return Homepage();
//                 },
//               ),
//               DiseaseView(),
//               Container(
//                 color: Colors.blue,
//               ),
//               ProfileScreen(),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 20,
//                 color: Colors.black.withOpacity(.1),
//               ),
//             ],
//           ),
//           child: SafeArea(
//             child: Padding(
//               padding:
//               const EdgeInsets.symmetric(horizontal: 22.0, vertical: 12),
//               child: GNav(
//                 onTabChange: controller.changeTabIndex,
//                 gap: 8,
//                 activeColor: Colors.white,
//                 iconSize: 24,
//                 padding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                 duration: const Duration(milliseconds: 500),
//                 tabBackgroundColor: Colors.green,
//                 color: Colors.black38,
//                 tabs: const [
//                   GButton(
//                     icon: LineIcons.home,
//                     text: 'Home',
//                   ),
//                   GButton(
//                     icon: LineIcons.pollH,
//                     text: 'Detector',
//                   ),
//                   GButton(
//                     icon: LineIcons.lineChart,
//                     text: 'Market',
//                   ),
//                   GButton(
//                     icon: LineIcons.user,
//                     text: 'Profile',
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }
//
