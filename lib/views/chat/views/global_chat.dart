import 'package:flutter/material.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/views/chat/widgets/bottom_chat_field.dart';
import 'package:frontend/views/chat/widgets/chat_list.dart';
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
        appBar: AppBar(
          title: const Text('#AskGPT'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ChatList(
                receiverUserId: user.user.value.userId??"",
                isGroupChat: true,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(size.width * 0.04),
              child: BottomChatField(
                recieverUserId: user.user.value.userId??"",
                isGroupChat: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
