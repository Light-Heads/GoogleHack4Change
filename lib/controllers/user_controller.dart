import 'dart:ffi';
import 'dart:io';

import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:frontend/config.dart';
import 'package:frontend/core/utils.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/navigation.dart';
import 'package:frontend/views/workers/work_screen.dart';
import 'package:get/get.dart';

var dio = d.Dio();

class UserController extends GetxController {
  var user = UserModel().obs;

  void addUser(
    context, {
    required String userId,
    required String name,
    required String phone,
    required String email,
    required int role,
    required String image,
    required num lat,
    required num long,
    required String polygonId,
    required String district,
    required String city,
    required String state,
    required String locality,
  }) async {
    try {
      String apiUrl = '$monngoAPIURL/addUser';
      var roleName = '';
      if (role == 1) {
        roleName = 'farmer';
      } else if (role == 2) {
        roleName = 'worker';
      } else if (role == 3) {
        roleName = 'business';
      } else {
        roleName = 'admin';
      }
      var response = await dio.post(apiUrl, data: {
        'name': name,
        'userId': userId,
        'phone': phone,
        'email': email,
        'role': roleName,
        'image': image,
        'location': [lat, long],
        'polygonId': polygonId,
        'district': district,
        'city': city,
        'state': state,
        'locality': locality,
      });
      print(response);
      user.value = UserModel.fromJson(response.data['user']);
      if (roleName == "worker") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => WorkerScreen()),
        );
      }
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Navigation()),
      );
    } catch (e) {
      print(e);
      showSnackBar(context, e.toString());
    }
  }

  getUser(String userId) async {
    try {
      String apiUrl = '$monngoAPIURL/getUser/$userId';
      var res = await dio.get(apiUrl);
      user.value = UserModel.fromJson(res.data['user']);
      print(user.value.userId);
    } catch (e) {
      print(e);
    }
  }

  signOut() async {
    user.value = UserModel();
  }
}
