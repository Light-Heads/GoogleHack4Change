import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frontend/navigation.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/views/home/homepage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PolygonLoader extends StatefulWidget {
  const PolygonLoader({super.key});

  @override
  State<PolygonLoader> createState() => _PolygonLoaderState();
}

class _PolygonLoaderState extends State<PolygonLoader> {
  int _currentIndex = 0;
  List<String> textList = [
    "Harvesting Your Farm Insights...",
    "Crafting the Perfect Polygon...",
    "Unleashing Powerful Analysis...",
  ]; // Add your list of texts here

  @override
  void initState() {
    super.initState();
    _startTextAnimation();
  }

  void _startTextAnimation() {
    Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % textList.length;
      });

      // Check if the list has ended
      if (_currentIndex == 0) {
        timer.cancel();
        // Navigate to a new page when the list ends
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Navigation()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textList[_currentIndex],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            LoadingAnimationWidget.threeRotatingDots(
              color: Pallete.greenColor,
              size: 200,
            ),
          ],
        ),
      ),
    );
  }
}
