import 'package:flutter/material.dart';
import 'package:frontend/controllers/commodity_controller.dart';
import 'package:frontend/controllers/location_controller.dart';
import 'package:frontend/controllers/polygon_controller.dart';
import 'package:frontend/controllers/weather_controller.dart';
import 'package:frontend/core/buttons.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/theme.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

final polygon = Get.put(PolygonController());

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final controller = Get.put(CommodityController());
    final location = Get.put(LocationController());
    final weather = Get.put(WeatherController());

    return SafeArea(
      child: Scaffold(body: Obx(() {
        return controller.isDataLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                body: SafeArea(
                  child: SizedBox(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: [
                        Container(
                          height: size.height * 0.32,
                          color: Pallete.veryLightGreenColor,
                          width: size.width,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 18.0, right: 18, top: 18, bottom: 2),
                            child: Stack(
                              children: [
                                Positioned(
                                  right: 0,
                                  child: SizedBox(
                                    child: Container(
                                        width: size.width * 0.5,
                                        child: Image.asset(
                                          'assets/images/All.png',
                                        )),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 18.0),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                              'assets/images/Location.png'),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            location.currentAddress.toString(),
                                            style: sub1,
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 18.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    '${weather.weather.value.main!.temp.toString()}°',
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 37,
                                                      fontFamily: 'Gilroy',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 1.12,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 8.0),
                                                    child: Text('Fahrenheit',
                                                        style: sub1.copyWith(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            fontSize: 18)),
                                                  )
                                                ],
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0x3FACACAC),
                                                      blurRadius: 19,
                                                      offset: Offset(0, 9),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: Image.network(
                                                  'https://openweathermap.org/img/wn/${weather.weather.value.weather![0].icon}@2x.png',
                                                  scale: 2,
                                                ),
                                              ),
                                              Text(
                                                  weather.weather.value
                                                      .weather![0].description
                                                      .toString(),
                                                  style: sub1),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 18.0),
                                          child: InkWell(
                                              onTap: () {
                                              },
                                              child: Button(size, "View More")),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      })),
    );
  }


}
