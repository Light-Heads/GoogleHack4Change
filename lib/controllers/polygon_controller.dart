
import 'package:dio/dio.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/polygon.dart';
import 'package:frontend/models/polystats.dart';
import 'package:frontend/models/soilmoisture.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

var dio = Dio();

class PolygonController extends GetxController {
  var polygondata = PolygonModel().obs;
  var soilMoisture = SoilMoistureModel().obs;
  var isLoading = false.obs;
  var uvIndex = 0.0.obs;
  var ndvi = PolyStatsModel().obs;
  var evi = PolyStatsModel().obs;
  var evi2 = PolyStatsModel().obs;
  var nri = PolyStatsModel().obs;
  var dswi = PolyStatsModel().obs;
  var ndwi = PolyStatsModel().obs;

  createPolygon(List<LatLng> coordinates) async {
    var res = await dio.post('$APIURL/polygons?appid=$APIKey', data: {
      "name": "Polygon 1",
      "geo_json": {
        "type": "Feature",
        "properties": {},
        "geometry": {
          "type": "Polygon",
          "coordinates": [
            coordinates.map((e) => [e.longitude, e.latitude]).toList()
          ],
        }
      }
    });
    polygondata.value = PolygonModel.fromMap(res.data);
  }

  getData(String polygonId) async {
    getSoilMoisture(polygonId);
    getUVIndex(polygonId);
    getSatelliteImagery(polygonId);
  }

  getSoilMoisture(String polygonId) async {
    var res = await dio.get(
        'http://api.agromonitoring.com/agro/1.0/soil?polyid=$polygonId&appid=$APIKey');
    var soilMoistureData = SoilMoistureModel.fromJson(res.data);
    soilMoisture.value = soilMoistureData;
  }

  // get
  getUVIndex(String polygonId) async {
    var res = await dio.get(
        'http://api.agromonitoring.com/agro/1.0/uvi?polyid=$polygonId&appid=$APIKey');
    uvIndex.value = res.data['uvi'];
  }

  getSatelliteImagery(String polygonId) async {
    final DateTime now = DateTime.now();
    final DateTime end = now;
    final DateTime start = now.subtract(const Duration(days: 16));

    final int startTimestamp = start.millisecondsSinceEpoch ~/ 1000;
    final int endTimestamp = end.millisecondsSinceEpoch ~/ 1000;

    final String apiUrl =
        'http://api.agromonitoring.com/agro/1.0/image/search?start=$startTimestamp&end=$endTimestamp&polyid=$polygonId&appid=$APIKey';

    try {
      isLoading.value = true;
      var res = await dio.get(apiUrl);
      getNdviUrl(res.data[0]['stats']['ndvi']);
      getEviUrl(res.data[0]['stats']['evi']);
      getEvi2Url(res.data[0]['stats']['evi2']);
      getNriUrl(res.data[0]['stats']['nri']);
      getDswiUrl(res.data[0]['stats']['dswi']);
      getNdwiUrl(res.data[0]['stats']['ndwi']);
    } finally {
      isLoading.value = false;
    }
  }

  getNdviUrl(String url) async {
    var res = await dio.get(url);
    ndvi.value = PolyStatsModel.fromJson(res.data);
  }

  getEviUrl(String url) async {
    var res = await dio.get(url);
    evi.value = PolyStatsModel.fromJson(res.data);
  }

  getEvi2Url(String url) async {
    var res = await dio.get(url);
    evi2.value = PolyStatsModel.fromJson(res.data);
  }

  getNriUrl(String url) async {
    var res = await dio.get(url);
    nri.value = PolyStatsModel.fromJson(res.data);
  }

  getDswiUrl(String url) async {
    var res = await dio.get(url);
    dswi.value = PolyStatsModel.fromJson(res.data);
  }

  getNdwiUrl(String url) async {
    var res = await dio.get(url);
    ndwi.value = PolyStatsModel.fromJson(res.data);
  }
}
