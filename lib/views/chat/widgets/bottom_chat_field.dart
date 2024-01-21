import 'package:flutter/material.dart';
import 'package:frontend/views/chat/controller/chat_controller.dart';
import 'package:get/get.dart';
import 'package:frontend/pallete.dart';


class BottomChatField extends StatefulWidget {
  final String recieverUserId;
  final bool isGroupChat;
  const BottomChatField(
      {super.key, required this.recieverUserId, required this.isGroupChat});

  @override
  State<BottomChatField> createState() => _BottomChatFieldState();
}

class _BottomChatFieldState extends State<BottomChatField> {
  bool isShowSendButton = false;
  final TextEditingController _messageController = TextEditingController();
  FocusNode focusNode = FocusNode();
  final chat = Get.put(ChatController());

  @override
  void initState() {
    super.initState();
  }

  void sendTextMessage() async {
    if (isShowSendButton) {
      if (_messageController.text.characters.length > 260) {
        _messageController.text =
            _messageController.text.characters.take(260).toString();
      }
      chat.sendTextMessage(_messageController.text.trim());
      // ref.read(chatControllerProvider.notifier).sendTextMessage(
      //       context,
      //       _messageController.text.trim(),
      //     );
      setState(() {
        _messageController.text = '';
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextFormField(
                style: const TextStyle(
                  color: Colors.white,
                ),
                focusNode: focusNode,
                controller: _messageController,
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    setState(() {
                      isShowSendButton = true;
                    });
                  } else {
                    setState(() {
                      isShowSendButton = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Pallete.greenColor,
                  hintText: 'Type a message!',
                  hintStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width * 0.005),
              child: CircleAvatar(
                backgroundColor: Pallete.greenColor,
                radius: 25,
                child: GestureDetector(
                  child: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onTap: sendTextMessage,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
