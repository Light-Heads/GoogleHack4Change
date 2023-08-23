import 'package:flutter/material.dart';
import 'package:frontend/controllers/commodity_controller.dart';
import 'package:frontend/controllers/location_controller.dart';
import 'package:frontend/controllers/polygon_controller.dart';
import 'package:frontend/controllers/weather_controller.dart';
import 'package:frontend/core/buttons.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/theme.dart';
import 'package:frontend/views/weather/weather_detail.dart';
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
        return (controller.isDataLoading.value || location.isDataLoading.value || weather.isDataLoading.value)
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
                                                    '${weather.weather.value.main?.temp.toString()}°',
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => WeatherDetail()),
                                                );
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
                        ),
                        Container(
                          width: size.width*0.9,
                          height: size.height*0.4,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 34,
                                offset: Offset(-2, 4),
                                spreadRadius: 0,
                              )
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(28.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Current Conditions", style: h1,),
                                SizedBox(height: size.height*0.01,),
                                Text("This data directly comes from satellite", style: sub1,)

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: size.height*0.03,),
                        Container(
                          child: Center(
                            child: Text(
                              'View More Insights',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.96,
                                fontFamily: 'Gilroy',
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.80,
                              ),
                            ),
                          ),
                          width: size.width*0.9,
                          height: size.height*0.07,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(16)),
                            image: DecorationImage(
                              image: AssetImage("assets/images/satelite.gif"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),


                      ],
                    ),

                  ),
                ),
              );
      })),
    );
  }


}
