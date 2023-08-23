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
import 'package:frontend/controllers/auth_controller.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

import '../../pallete.dart';
import '../../theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var auth = Get.put(AuthController());
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                        child: IconButton(onPressed: (){
                            auth.signOut();
                          },
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Settings()),
                          // );
                            icon:Icon(Icons.logout, size: 30,)),
                      )

                    ],
                  ),
                ],
              ),
            ),
              // CircleAvatar(radius: 50,),
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Text("Your Name", style: sub1.copyWith(fontSize: 22, fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: size.height*0.02,),
              Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Text("Farmer", style: sub1.copyWith(fontSize: 18, fontWeight: FontWeight.w600, color: Pallete.greenColor),),
              ),
          ]
      ),
    ),
    ), );
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
