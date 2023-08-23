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
import 'package:line_icons/line_icons.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';

import '../../theme.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 20),
                  child: Text(
                    "PROFILE",
                    style: h1.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 28.0, top: 20),
                child: IconButton(onPressed: (){
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => Settings()),
                  // );

                }, icon: Icon(LineIcons.cog, size: 30,)),
              )
            ],
          ),

              CircleAvatar(radius: 50,),
              Text("Your Name"),

              




          ]
      ),
    ),
    ), );
  }
}


  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
