import 'package:dio/dio.dart';
import 'package:frontend/config.dart';
import 'package:frontend/models/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

var dio = Dio();

class WeatherController extends GetxController {
  // var
  var weather = WeatherModel().obs;
  var forecastWeatherList = [].obs;
  var isDataLoading = false.obs;
  getCurrentWeatherData(Position position) async {
    try {
      isDataLoading.value = true;
      var res = await dio.get(
          '${APIURL}/weather?lat=${position.latitude}&lon=${position.longitude}&appid=$APIKey');
      weather.value = WeatherModel.fromJson(res.data);
    } catch (e) {
      print(e);
    } finally {
      isDataLoading.value = false;
    }
  }

  getForecastWeatherData(Position position) async {
    try {
      List<WeatherModel> forecastWeather = [];
      var res = await dio.get(
          '$APIURL/weather/forecast?lat=${position.latitude}&lon=${position.longitude}&appid=$APIKey');
      for (var f in res.data) {
        forecastWeather.add(WeatherModel.fromJson(f));
      }
      forecastWeatherList.assignAll(forecastWeather);
      print(forecastWeatherList.length);
    } catch (e) {
      print(e);
    }
  }
}
