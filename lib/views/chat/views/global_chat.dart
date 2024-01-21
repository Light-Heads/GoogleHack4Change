import 'package:flutter/material.dart';
import 'package:flutter_octicons/flutter_octicons.dart';
import 'package:frontend/controllers/nav_controller.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/navigation.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/views/chat/widgets/bottom_chat_field.dart';
import 'package:frontend/views/chat/widgets/chat_list.dart';
import 'package:frontend/views/home/homepage.dart';
import 'package:get/get.dart';

class MobileChatScreen extends StatefulWidget {
  const MobileChatScreen({super.key});

  @override
  State<MobileChatScreen> createState() => _MobileChatScreenState();
}

class _MobileChatScreenState extends State<MobileChatScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Get.put(UserController());
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const Navigation(tabIndex: 0),
              //   ),
              // );
            },
            icon: const Icon(
              OctIcons.arrow_left_16,
              color: Colors.black,
            ),
          ),
          title: const Text('#AskSahay!'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding:  EdgeInsets.symmetric(horizontal: 18,),
                child: ChatList(
                  receiverUserId: user.user.value.userId ?? "",
                  isGroupChat: true,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.08),
              child: BottomChatField(
                recieverUserId: user.user.value.userId ?? "",
                isGroupChat: true,
              ),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
