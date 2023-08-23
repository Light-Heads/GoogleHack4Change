import 'package:flutter/material.dart';

import '../pallete.dart';
import '../theme.dart';

class RoleSelectionScreen extends StatefulWidget {
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 28.0, top: 20),
                  child: IconButton(
                    onPressed: (){
                      // Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back, size: 30,color: Colors.black,),
                  )
              ),
            ),
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
            RoleContainer(
              role: 1,
              roleName: 'Farmer',
              isSelected: selectedRole == 1,
              onTap: () => _selectRole(1),
            ),
            SizedBox(height: 20),
            RoleContainer(
              role: 2,
              roleName: 'Worker',
              isSelected: selectedRole == 2,
              onTap: () => _selectRole(2),
            ),
            SizedBox(height: 20),
            RoleContainer(
              role: 3,
              roleName: 'Business',
              isSelected: selectedRole == 3,
              onTap: () => _selectRole(3),
            ),
          ],
        ),
      ),
    );
  }
}

class RoleContainer extends StatelessWidget {
  final int role;
  final String roleName;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleContainer({
    required this.role,
    required this.roleName,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 100,
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
                margin: EdgeInsets.all(10),
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
                    ? Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                )
                    : null,
              ),
            ),
            Center(
              child: Text(
                roleName,
                style: TextStyle(
                  color: isSelected ? Pallete.greenColor : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}