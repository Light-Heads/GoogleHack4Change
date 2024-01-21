// import 'package:flutter/material.dart';
// import 'package:frontend/controllers/auth_controller.dart';
// import 'package:get/get.dart';
//
// class ProfileView extends StatefulWidget {
//   const ProfileView({super.key});
//
//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }
//
// class _ProfileViewState extends State<ProfileView> {
//   @override
//   Widget build(BuildContext context) {
//     var auth = Get.put(AuthController());
//     return SafeArea(
//         child: Scaffold(
//       body: Column(
//         children: [
//           Center(
//             child: Text("Profile"),
//           ),
//           ElevatedButton(
//               onPressed: () {
//                 auth.signOut();
//               },
//               child: Text("Logout"))
//         ],
//       ),
//     ));
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/common/jobs_card.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/controllers/nav_controller.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/controllers/work_controller.dart';
import 'package:frontend/core/buttons.dart';
import 'package:frontend/views/auth/login.dart';
import 'package:frontend/views/user/workfrom.dart';
import 'package:frontend/views/workers/work_screen.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../pallete.dart';
import '../../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    var user = Get.put(UserController());
    var work = Get.put(WorkController());
    work.getWorkByUserId(context, user.user.value.userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Get.put(AuthController());
    var user = Get.put(UserController());
    var work = Get.put(WorkController());
    var nav = Get.put(NavigationController());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.profile,
                        style: h1.copyWith(fontSize: 34, color: Colors.black),
                      ),
                      IconButton(
                          onPressed: () async {
                            await auth.signOut();
                            await user.signOut();
                            Navigator.popUntil(context, (route) => false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                            nav.changeTabIndex(0);

                          },
                          
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Settings()),
                          // );
                          icon: Icon(
                            Icons.logout,
                            size: 30,
                          ))
                    ],
                  ),
                ],
              ),
            ),
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(user.user.value.image ??
                  "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Text(
              user.user.value.name ?? "Farmweller",
              style: sub1.copyWith(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            // Text(
            //   // AppLocalizations.of(context)!.farmer,
            //   style: sub1.copyWith(
            //       fontSize: 18,
            //       fontWeight: FontWeight.w600,
            //       color: Pallete.greenColor),
            // ),
            SizedBox(
              height: size.height * 0.02,
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProjectForm()),
                  );
                },
                child: Button(size, "Add Work")),
            Container(
              height: size.height * 0.44,
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: work.workList.length,
                  itemBuilder: (context, index) {
                    return JobsComponent(
                        size: size, workModel: work.workList[index]);
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}

Widget _buildQuoteItem(String title, String subTitle, IconData icon) {
  return ListTile(
    leading: Icon(icon),
    title: Text(title),
    subtitle: Text(subTitle),
  );
}

class TabBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(text: 'My Quotes'),
                Tab(text: 'My Requests'),
              ],
            ),
            TabBarView(
              children: [
                MyQuotesTab(),
                MyRequestsTab(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MyQuotesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Quotes Tab Content'),
    );
  }
}

class MyRequestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Requests Tab Content'),
    );
  }
}
