import 'package:flutter/material.dart';
import 'package:frontend/views/classifier/disease.dart';
import 'package:frontend/views/commodity/commodityview.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class ServicesController extends GetxController {
  final services = [
    {'name': 'Add FarmField', 'icon': LineIcons.tractor, 'onTap': () {}},
    {
      'name': 'Detect Disease',
      'icon': LineIcons.leaf,
      'onTap': DiseaseView(),
    },
    {
      'name': 'Mandi Prices', 'icon': LineIcons.indianRupeeSign, 'onTap': CommodityView(),
    },
    {'name': 'Weather', 'icon': LineIcons.cloud, 'onTap': () {}},
    {'name': 'Market', 'icon': LineIcons.shoppingCart, 'onTap': () {}},
    {'name': 'Chat', 'icon': LineIcons.comment, 'onTap': () {}},
    {'name': 'Settings', 'icon': LineIcons.cog, 'onTap': () {}},
  ].obs;
}
