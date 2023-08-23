
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget Button(size, text)
{
  return Container(
    child:  Center(
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Gilroy',
          fontWeight: FontWeight.w600,
          letterSpacing: -0.56,
        ),
      ),
    ),
    width: size.width*0.45,
    height: size.height*0.06,
    decoration: ShapeDecoration(
      color: Color(0xFF65D893),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(27),
      ),
      shadows: [
        BoxShadow(
          color: Color(0x5965D893),
          blurRadius: 17,
          offset: Offset(0, 13),
          spreadRadius: 0,
        )
      ],
    ),
  );
}