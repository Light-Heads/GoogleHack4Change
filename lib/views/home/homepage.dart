import 'package:flutter/material.dart';
import 'package:frontend/controllers/commodity_controller.dart';
import 'package:frontend/controllers/language_controller.dart';
import 'package:frontend/controllers/location_controller.dart';
import 'package:frontend/controllers/polygon_controller.dart';
import 'package:frontend/controllers/products_controller.dart';
import 'package:frontend/controllers/services_controller.dart';
import 'package:frontend/controllers/user_controller.dart';
import 'package:frontend/controllers/weather_controller.dart';
import 'package:frontend/core/buttons.dart';
import 'package:frontend/core/utils.dart';
import 'package:frontend/models/weather.dart';
import 'package:frontend/pallete.dart';
import 'package:frontend/theme.dart';
import 'package:frontend/views/chat/views/global_chat.dart';
import 'package:frontend/views/classifier/disease.dart';
import 'package:frontend/views/commodity/commodityview.dart';
import 'package:frontend/views/market/marketpage.dart';
import 'package:frontend/views/polygon/polygon.dart';
import 'package:frontend/views/user/profile.dart';
import 'package:frontend/views/weather/weather_detail.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:line_icons/line_icons.dart';

import '../polygon/suggestions.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

final polygon = Get.put(PolygonController());
final user = Get.put(UserController());
final product = Get.put(ProductController());

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) async {
      await polygon.getData(user.user.value.polygonId ?? "");
      // await product.getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final controller = Get.put(CommodityController());
    final location = Get.put(LocationController());
    final weather = Get.put(WeatherController());
    // final services = Get.put(ServicesController());

    final services = [
      {
        'name': AppLocalizations.of(context)!.addField,
        'icon': LineIcons.tractor,
        'onTap': PolygonScreen(
          isLoggedIn: true,
        )
      },
      {
        'name': AppLocalizations.of(context)!.detect,
        'icon': LineIcons.leaf,
        'onTap': DiseaseView(),
      },
      {
        'name': AppLocalizations.of(context)!.mandiPrice,
        'icon': LineIcons.indianRupeeSign,
        'onTap': CommodityView(),
      },
      {
        'name': AppLocalizations.of(context)!.weather,
        'icon': LineIcons.cloud,
        'onTap': WeatherDetail()
      },
      {
        'name': AppLocalizations.of(context)!.market,
        'icon': LineIcons.shoppingCart,
        'onTap': ProductListing()
      },
      {
        'name': AppLocalizations.of(context)!.chat,
        'icon': LineIcons.comment,
        'onTap': MobileChatScreen()
      },
      {
        'name': AppLocalizations.of(context)!.settings,
        'icon': LineIcons.cog,
        'onTap': ProfileScreen()
      },
    ];

    return SafeArea(
      child: Scaffold(body: Obx(() {
        num c = 273.15;
        final celciusweather = weather.weather.value.main?.temp ?? 0;
        num finalweathertemp = celciusweather - c;
        String nitrogen =
            calculateNitrogen(polygon.ndvi.value.mean ?? 0.toDouble());
        String health =
            calculateHealth(context, polygon.ndvi.value.mean ?? 0.toDouble());

        String waterStress = calculateWaterStress(
            context,
            polygon.ndvi.value.mean ?? 0.toDouble(),
            polygon.dswi.value.mean ?? 0.toDouble());
        return (controller.isDataLoading.value ||
                location.isDataLoading.value ||
                weather.isDataLoading.value)
            ? const Center(child: CircularProgressIndicator())
            : Obx(
                () => Scaffold(
                  body: SafeArea(
                    child: SizedBox(
                      height: size.height,
                      width: size.width,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WeatherDetail()),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  color: Pallete.veryLightGreenColor,
                                  width: size.width,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        right: 0,
                                        child: SizedBox(
                                          child: Container(
                                            width: size.width * 0.3,
                                            child: Image.asset(
                                              'assets/images/All.png',
                                            ),
                                          ),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 18.0),
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Image.asset(
                                                    'assets/images/Location.png'),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  location.currentAddress
                                                      .toString(),
                                                  style: sub1,
                                                ),
                                                Spacer(),
                                                Container(
                                                  // drop down menu for selecting languages material ui
                                                  margin: const EdgeInsets.only(
                                                      top: 20, right: 20),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.transparent,
                                                  ),
                                                  child: DropdownButton<String>(
                                                    dropdownColor:
                                                        Colors.white,
                                                    value: Get.find<
                                                            LanguageController>()
                                                        .value
                                                        .value,
                                                    icon: Icon(
                                                      Icons.arrow_drop_down,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                    ),
                                                    iconSize: size.width * 0.07,
                                                    elevation: 16,
                                                    style: TextStyle(
                                                        color: const Color
                                                            .fromARGB(
                                                            255, 0, 0, 0)),
                                                    underline: SizedBox(),
                                                    onChanged:
                                                        (String? newValue) {
                                                      if (newValue ==
                                                          'English') {
                                                        Get.find<
                                                                LanguageController>()
                                                            .updateLocale('en');
                                                      } else if (newValue ==
                                                          'हिंदी') {
                                                        Get.find<
                                                                LanguageController>()
                                                            .updateLocale('hi');
                                                      } else if (newValue ==
                                                          'తెలుగు') {
                                                        Get.find<
                                                                LanguageController>()
                                                            .updateLocale('te');
                                                      }
                                                    },
                                                    items: <String>[
                                                      'English',
                                                      'हिंदी',
                                                      'తెలుగు'
                                                    ].map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(
                                                          value,
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                        ),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.01,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 18.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '${finalweathertemp.toString().substring(0, 4)}°',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 37,
                                                              fontFamily:
                                                                  'Gilroy',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              letterSpacing:
                                                                  1.12,
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    top: 8.0),
                                                            child: Text(
                                                                'Celcius',
                                                                style: sub1.copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        18)),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(
                                                                    0x3FACACAC),
                                                                blurRadius: 19,
                                                                offset: Offset(
                                                                    0, 9),
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
                                                            weather
                                                                .weather
                                                                .value
                                                                .weather![0]
                                                                .description
                                                                .toString(),
                                                            style: sub1),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                              // Text(AppLocalizations.of(context)!
                                              //     .viewMore),
                                            ],
                                          ),
                                          // Row(
                                          //   mainAxisAlignment:
                                          //       MainAxisAlignment.end,
                                          //   children: [
                                          //     Padding(
                                          //       padding:
                                          //           EdgeInsets.only(right: 18.0),
                                          //       child: InkWell(
                                          //           onTap: () {
                                          //             Navigator.push(
                                          //               context,
                                          //               MaterialPageRoute(
                                          //                   builder: (context) =>
                                          //                       WeatherDetail()),
                                          //             );
                                          //           },
                                          //           child: Button(
                                          //               size,
                                          //               AppLocalizations.of(
                                          //                       context)!
                                          //                   .viewMore)),
                                          //     ),
                                          //   ],
                                          // )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.9,
                              // height: size.height * 0.,
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
                                    Text(
                                      AppLocalizations.of(context)!.current,
                                      style: h1,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Text(
                                      AppLocalizations.of(context)!
                                          .directSatellite,
                                      style: sub1,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(18.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            children: [
                                              Image.asset(
                                                  "assets/images/heart.gif"),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .health,
                                                style: h1.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              Text(health),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Image.asset(
                                                  "assets/images/water.gif"),
                                              SizedBox(
                                                height: size.height * 0.02,
                                              ),
                                              Text(
                                                AppLocalizations.of(context)!
                                                    .waterStress,
                                                style: h1.copyWith(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 14),
                                              ),
                                              SizedBox(
                                                height: size.height * 0.01,
                                              ),
                                              Text(waterStress),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Center(
                                        child: Text(
                                      AppLocalizations.of(context)!.nitGood,
                                      style: h1.copyWith(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 14),
                                    )),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SugesstionScreen(
                                                    nitrogen: nitrogen,
                                                    waterStress: waterStress,
                                                    health: health,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .viewSuggestions,
                                            style: TextStyle(
                                              color: Pallete.whiteColor,
                                              fontSize: 17.96,
                                              fontFamily: 'Gilroy',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: -0.80,
                                            ),
                                          ),
                                        ),
                                        width: size.width * 0.9,
                                        height: size.height * 0.07,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 27,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                          color: Pallete.greenColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(16)),
                                          // image: DecorationImage(
                                          //   image: AssetImage("assets/images/satelite.gif"),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.03,
                            ),
                            Container(
                              width: size.width * 0.9,
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
                              // height: size.height * 0.3,
                              padding: const EdgeInsets.all(28.0),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppLocalizations.of(context)!.featured,
                                      style: h1,
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        crossAxisSpacing: 10,
                                        mainAxisSpacing: 12,
                                        childAspectRatio: 0.8,
                                      ),
                                      itemCount: services.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                width: size.width * 0.13,
                                                height: size.height * 0.05,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                services[index][
                                                                        'onTap']
                                                                    as Widget));
                                                  },
                                                  icon: Icon(
                                                    services[index]['icon']
                                                        as IconData?,
                                                    size: 34,
                                                    color: Pallete.greenColor,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                  width: size.width * 0.14,
                                                  child: Center(
                                                    child: Text(
                                                      services[index]['name']
                                                          as String,
                                                      maxLines: 2,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          letterSpacing: 0.5),
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        );
                                      },
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ]),
                            ),
                            SizedBox(
                              height: size.height * 0.15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
      })),
    );
  }
}
