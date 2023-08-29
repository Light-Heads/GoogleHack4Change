// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:frontend/views/auth/form.dart';

import '../../core/buttons.dart';
import '../../pallete.dart';
import '../../theme.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  _RoleSelectionScreenState createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  int selectedRole = 0; // 0: None, 1: Role A, 2: Role B, 3: Role C

  void _selectRole(int role) {
    setState(() {
      selectedRole = role;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Padding(
            //       padding: const EdgeInsets.only(left: 28.0, top: 20),
            //       child: IconButton(
            //         onPressed: (){
            //           // Navigator.pop(context);
            //         },
            //         icon: Icon(Icons.arrow_back, size: 30,color: Colors.black,),
            //       )
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Choose Your Role", style: h1.copyWith(fontSize: 34, color: Colors.black),),
                  Text("Your role personalizes your \ncontent", style: sub1,),
                  SizedBox(height: size.height*0.03,),
                  Text("You can choose from below", style: sub1.copyWith(fontSize: 16, fontWeight: FontWeight.w800, color: Pallete.greenColor),),
                ],
              ),
            ),
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  RoleContainer(
                    role: 1,
                    roleName: 'Farmer',
                    isSelected: selectedRole == 1,
                    onTap: () => _selectRole(1), roleImageAsset: 'assets/images/farmer.png',
                  ),
                  const SizedBox(height: 20),
                  RoleContainer(
                    role: 2,
                    roleName: 'Worker',
                    isSelected: selectedRole == 2,
                    onTap: () => _selectRole(2), roleImageAsset: 'assets/images/worker.png',
                  ),
                  const SizedBox(height: 20),
                  // RoleContainer(
                  //   role: 3,
                  //   roleName: 'Business',
                  //   isSelected: selectedRole == 3,
                  //   onTap: () => _selectRole(3), roleImageAsset: 'assets/images/business.png',
                  // ),
                ],
              ),
            ),
            SizedBox(height: size.height*0.05,),
            InkWell(
              onTap:(){
                Navigator.push(context, MaterialPageRoute(builder: (context) => FormView(roleid: selectedRole,)));
              },
                child: Center(child: Button(size, "Next"))),

          ],
        ),
      ),
    );
  }
}

class RoleContainer extends StatelessWidget {
  final String roleImageAsset;
  final int role;
  final String roleName;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleContainer({super.key, 
    required this.role,
    required this.roleName,
    required this.isSelected,
    required this.onTap, required this.roleImageAsset,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width*0.80,
        height: size.height*0.1,
        decoration: BoxDecoration(
          color: isSelected ? Pallete.lightGreenColor: Colors.white,
          border: Border.all(
            color: isSelected ? Colors.lightGreen : Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.all(10),
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isSelected ? Colors.lightGreen : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? Colors.lightGreen : Colors.grey,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                )
                    : null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 55,
                      width: 55,
                      child: Image.asset(roleImageAsset,)),
                  Text(
                    roleName,
                    style: TextStyle(
                      color: isSelected ? Pallete.greenColor : Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}