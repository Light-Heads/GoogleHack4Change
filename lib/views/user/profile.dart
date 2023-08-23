import 'package:flutter/material.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    var auth = Get.put(AuthController());
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Center(
            child: Text("Profile"),
          ),
          ElevatedButton(
              onPressed: () {
                auth.signOut();
              },
              child: Text("Logout"))
        ],
      ),
    ));
  }
}
