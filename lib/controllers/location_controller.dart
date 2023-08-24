import 'package:flutter/material.dart';
import 'package:frontend/controllers/weather_controller.dart';
import 'package:frontend/core/utils.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';


class LocationController extends GetxController {
  var isDataLoading = false.obs;
  var location = [].obs;
  var currentAddress = "".obs;
  var city = "".obs;
  var state = "".obs;
  var country = "".obs;
  var district = "".obs;
  var locality = "".obs;
  var postalCode = "".obs;
  Position? _currentPosition;
  var position = Position(
      longitude: 0.0,
      latitude: 0.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0);
  @override
  void onInit() {
    super.onInit();
    getCurrentPosition();
  }

  WeatherController weather = Get.put(WeatherController());

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      showSnackBar(Get.context!,
          'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        showSnackBar(Get.context!,
            'Location permissions are denied. Please enable the permissions');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      showSnackBar(Get.context!,
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<void> getCurrentPosition() async {
    isDataLoading.value = true;
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position p) {
      _currentPosition = p;
      position = p;
      print(position);
      _getAddressFromLatLng(_currentPosition!);
      weather.getCurrentWeatherData(_currentPosition!);
      weather.getForecastWeatherData(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
    isDataLoading.value = false;
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      currentAddress.value =
      '${place.street},${place.subLocality}';
      city.value = place.locality??'';
      state.value = place.administrativeArea??'';
      country.value = place.country??'';
      district.value = place.subAdministrativeArea??'';
      locality.value = place.subLocality??'';
      postalCode.value = place.postalCode??'';
      // currentAddress.value =
      //     '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
