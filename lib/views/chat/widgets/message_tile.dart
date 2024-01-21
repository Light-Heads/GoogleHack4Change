import 'package:flutter/material.dart';
import 'package:frontend/pallete.dart';

Container MessageTile(Size size, Map<String, dynamic> chatMap, DateTime date) {
  return Container(
    margin: EdgeInsets.only(
        bottom: size.height * 0.025,
        left: size.width * 0.04,
        right: size.width * 0.02),
    width: size.width,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: size.width * 0.1,
          height: size.width * 0.1,
          decoration: BoxDecoration(
            color: Pallete.whiteColor,
            // image: DecorationImage(
            //   image: NetworkImage(chatMap['senderPhotoUrl']),
            //   fit: BoxFit.cover,
            // ),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        SizedBox(
          width: size.width * 0.04,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  chatMap['author'].split(' ')[0],
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  '${date.toString().split(' ').first} ${date.toString().split(' ')[1].split('.').first}',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Container(
              width: size.width * 0.7,
              child: Text(
                chatMap['content'],
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}