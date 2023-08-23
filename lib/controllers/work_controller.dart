import 'package:dio/dio.dart' as d;
import 'package:frontend/config.dart';
import 'package:frontend/models/workmodel.dart';
import 'package:get/get.dart';

class WorkController extends GetxController {
  var dio = d.Dio();
  var workList = [].obs;
  getWork(context, latitude, longitude) async {
    try {
      d.Response res = await dio.get('${flaskAPIURL}/work', data: {
        'location': [latitude, longitude]
      });
      var workListtemp = [];
      for (var f in res.data) {
        workListtemp.add(WorkModel.fromJson(f));
      }
      workList.assignAll(workListtemp);
    } catch (e) {
      print(e);
    }
  }

  addWork(context,
      {required title,
      required phone,
      required latitude,
      required longitude,
      required userId,
      required district,
      required requirment,
      required price,
      required date}) async {
    try {
      d.Response res = await dio.post('${flaskAPIURL}/work', data: {
        'title': title,
        'phone': phone,
        'location': {
          "type": "Point",
          "coordinates": [latitude, longitude]
        },
        'userId': userId,
        'district': district,
        'requirment': requirment,
        'price': price,
        'date': date
      });
      print(res.data);
    } catch (e) {
      print(e);
    }
  }

  getWorkByUserId(context, userId) async {
    try {
      d.Response res = await dio.get('${flaskAPIURL}/work/user/$userId');
      var workListtemp = [];
      for (var f in res.data) {
        workListtemp.add(WorkModel.fromJson(f));
      }
      workList.assignAll(workListtemp);
    } catch (e) {
      print(e);
    }
  }

  delWork(context, id) async {
    try {
      d.Response res = await dio.delete('${flaskAPIURL}/work', data: {
        '_id': id,
      });
      print(res.data);
    } catch (e) {
      print(e);
    }
  }
}
