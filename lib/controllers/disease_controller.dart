import 'dart:io';
import 'package:dio/dio.dart' as d;
import 'package:frontend/config.dart';
import 'package:frontend/core/utils.dart';
import 'package:frontend/models/disease.dart';
import 'package:get/get.dart';

var dio = d.Dio();

class DiseaseController extends GetxController {
  var disease = DiseaseModel().obs;
  getDisease(File image, context) async {
    try {
      d.FormData formData = d.FormData.fromMap({
        'image':
            await d.MultipartFile.fromFile(image.path, filename: 'image.jpg'),
      });
      d.Response response = await dio.post(flaskAPIURL, data: formData);
      disease.value = DiseaseModel.fromJson(response.data);
    } catch (e) {
      print(e);
      showSnackBar(context, 'Error');
    }
  }
}
