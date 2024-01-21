import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/polygon_controller.dart';
import '../../pallete.dart';
import '../../theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SugesstionScreen extends StatefulWidget {
  final String nitrogen;
  final String health;
  final String waterStress;
  const SugesstionScreen(
      {Key? key,
      required this.nitrogen,
      required this.health,
      required this.waterStress})
      : super(key: key);

  @override
  State<SugesstionScreen> createState() => _SugesstionScreenState();
}

final polygon = Get.put(PolygonController());

class _SugesstionScreenState extends State<SugesstionScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: const EdgeInsets.only(left: 28.0, top: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        size: 30,
                        color: Colors.black,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.suggestions,
                      style: h1.copyWith(fontSize: 34, color: Colors.black),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    Text(
                      AppLocalizations.of(context)!.basedSatellite,
                      style: sub1,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    FarmDataTile(poly: polygon),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      AppLocalizations.of(context)!.insights,
                      style: sub1.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Pallete.greenColor),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Insights(
                        poly: polygon,
                        nitrogen: widget.nitrogen,
                        health: widget.health,
                        waterStresss: widget.waterStress)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FarmDataTile extends StatelessWidget {
  final PolygonController poly;

  const FarmDataTile({super.key, required this.poly});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ExpansionTile(
        title: Text(
          AppLocalizations.of(context)!.yourFarmData,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        children: [
          // ListTile(
          //   title: Text('Polygon Data: ${poly.polygondata.value.createdAt}'),
          // ),
          ListTile(
            title: Text('Soil Moisture: ${poly.soilMoisture.value.moisture}'),
          ),
          ListTile(
            title: Text('UV Index: ${poly.uvIndex.value}'),
          ),
          ListTile(
            title: Text('NDVI: ${poly.ndvi.value.mean}'),
          ),
          ListTile(
            title: Text('EVI: ${poly.evi.value.mean}'),
          ),
          ListTile(
            title: Text('EVI2: ${poly.evi2.value.mean}'),
          ),
          ListTile(
            title: Text('NRI: ${poly.nri.value.mean}'),
          ),
          ListTile(
            title: Text('DSWI: ${poly.dswi.value.mean}'),
          ),
          ListTile(
            title: Text('NDWI: ${poly.ndwi.value.mean}'),
          ),
        ],
      ),
    );
  }
}

class Insights extends StatelessWidget {
  final PolygonController poly;
  final String nitrogen;
  final String health;
  final String waterStresss;

  const Insights(
      {Key? key,
      required this.poly,
      required this.nitrogen,
      required this.health,
      required this.waterStresss})
      : super(key: key);

  Color getColor(String value) {
    switch (value) {
      case "Low":
        return Colors.red;
      case "Medium":
        return Colors.yellow;
      case "High":
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String interpretCropHealth(BuildContext context, String healthScore) {
    if (healthScore == "High") {
      return AppLocalizations.of(context)!.vegHealthGood;
    } else {
      return AppLocalizations.of(context)!.vegHealthImprove;
    }
  }

  String interpretWaterStress(BuildContext context, waterStressScore) {
    switch (waterStressScore) {
      case "Low":
        return AppLocalizations.of(context)!.waterlimit;
      case "Medium":
        return "Moderate water stress detected. Consider adjusting irrigation.";
      case "High":
        return "High water stress detected. Immediate action required.";
      default:
        return "";
    }
  }

  String interpretNitrogenLevel(BuildContext context, String nitrogenLevel) {
    if (nitrogenLevel == "High") {
      return AppLocalizations.of(context)!.nitAdequate;
    } else {
      return AppLocalizations.of(context)!.nitLow;
    }
  }

  String interpretCropMaturity(BuildContext context, String cropMaturity) {
    if (cropMaturity == "High") {
      return AppLocalizations.of(context)!.nitAdequate;
    } else {
      return AppLocalizations.of(context)!.nitLow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        children: [
          ListTile(
            title: Text(
              AppLocalizations.of(context)!.actions,
              style: h1.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: Text('`${AppLocalizations.of(context)!.health}: `${health}'),
            subtitle: Text(interpretCropHealth(context, health)),
            trailing: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(health),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: Text(
                '`${AppLocalizations.of(context)!.waterStress}: ${waterStresss}'),
            subtitle: Text(interpretWaterStress(context, waterStresss)),
            trailing: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(waterStresss),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            title:
                Text('`${AppLocalizations.of(context)!.nitrogen}: ${nitrogen}'),
            subtitle: Text(interpretNitrogenLevel(context, nitrogen)),
            trailing: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(nitrogen),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: Text(
                '`${AppLocalizations.of(context)!.maturity}`: ${nitrogen}'),
            subtitle: Text(interpretNitrogenLevel(context, nitrogen)),
            trailing: Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(nitrogen),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
