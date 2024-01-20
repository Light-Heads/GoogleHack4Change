import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/views/chat/controller/chat_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/scheduler.dart';
import 'package:frontend/views/chat/widgets/message_tile.dart';

class ChatList extends StatefulWidget {
  final String receiverUserId;
  final bool isGroupChat;

  const ChatList({
    Key? key,
    required this.receiverUserId,
    required this.isGroupChat,
  }) : super(key: key);

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final ScrollController messageController = ScrollController();
  List<Map<String, dynamic>> messages = []; // Store messages from the server

  @override
  void initState() {
    super.initState();
  }

  final chat = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Obx(
      () => ListView.builder(
        itemCount: chat.MessagesList.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> chatMap = chat.MessagesList[index];
          DateTime date = DateTime.now();

          return InkWell(
            onLongPress: () {
              // Add your long-press logic here
            },
            child: MessageTile(size, chatMap, date),
          );
        },
      ),
    );
  }
}
