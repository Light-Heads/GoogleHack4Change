import 'package:flutter/material.dart';
import 'package:frontend/views/auth/roles.dart';
import 'package:frontend/controllers/auth_controller.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/navigation.dart';
import 'package:get/get.dart';

import 'views/workers/work_screen.dart';

class RoleLoader extends StatefulWidget {
  const RoleLoader({super.key});

  @override
  State<RoleLoader> createState() => RoleLoaderState();
}

class RoleLoaderState extends State<RoleLoader> {
  final auth = Get.put(AuthController());
  final user = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user.getUser(auth.user.uid),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }

        if (userSnapshot.hasError) {
          return const Text("Error fetching user data.");
        }

        // User data has been successfully fetched.
        if (user.user.value.role != null) {
          if (user.user.value.role == 'worker') {
            return const WorkerScreen();
          } else {
            return const Navigation();
          }
        } else {
          return const RoleSelectionScreen();
        }
      },
    );
  }
}
