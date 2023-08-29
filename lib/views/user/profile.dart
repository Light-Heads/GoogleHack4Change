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

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:frontend/common/jobs_card.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/controllers/work_controller.dart';
import 'package:frontend/core/buttons.dart';
import 'package:frontend/views/auth/login.dart';
import 'package:frontend/views/user/workfrom.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

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
                        "Profile",
                        style: h1.copyWith(fontSize: 34, color: Colors.black),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 28.0),
                        child: IconButton(
                            onPressed: () async {
                              await auth.signOut();
                              await user.signOut();
                              Navigator.popUntil(context, (route) => false);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginScreen()));
                            },
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (context) => Settings()),
                            // );
                            icon: const Icon(
                              Icons.logout,
                              size: 30,
                            )),
                      )
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
                    MaterialPageRoute(builder: (context) => const ProjectForm()),
                  );
                },
                child: Button(size, "Add Work")),
            SizedBox(
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


class TabBarScreen extends StatelessWidget {
  const TabBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
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
  const MyQuotesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('My Quotes Tab Content'),
    );
  }
}

class MyRequestsTab extends StatelessWidget {
  const MyRequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('My Requests Tab Content'),
    );
  }
}
