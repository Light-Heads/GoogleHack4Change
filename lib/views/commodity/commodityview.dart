import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/commodity_controller.dart';
import 'package:frontend/models/commodity.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../pallete.dart';
import '../../theme.dart';


class CommodityView extends StatefulWidget {
  const CommodityView({Key? key}) : super(key: key);

  @override
  State<CommodityView> createState() => _CommodityViewState();
}
final commodity = Get.put(CommodityController());
class _CommodityViewState extends State<CommodityView> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mandi Prices",
                        style: h1.copyWith(fontSize: 34, color: Colors.black),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text(
                        "Today's Mandi\nPrices",
                        style: sub1,
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Text(
                        "Per 1 Ton",
                        style: sub1.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: Pallete.greenColor),
                      ),
                    ],
                  ),
                ),
                Obx(() =>
                  (commodity.isDataLoading.value)?
                  Center(child: CircularProgressIndicator()):
                  SizedBox(
                      height: size.height*0.7,
                      width: size.width,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: commodity.commodity.value.records!.length,
                          itemBuilder: (context, i){
                            return Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: CommodityCard(size, commodity.commodity.value.records![i]),
                            );
                          })
                  ),
                ),
              ],
            ),
          ),

        ),
      ),
    );
  }

  // String? state;
  // String? district;
  // String? market;
  // String? commodity;
  // String? variety;
  // String? grade;
  // String? arrivalDate;
  // String? minPrice;
  // String? maxPrice;
  // String? modalPrice;

  Widget CommodityCard(size, Records com)
  {
    return Container(
      width: size.width*0.84,
      height: size.height*0.14,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height*0.01,),
                Text(
                  '${com.variety} ',
                  style: TextStyle(
                    color: Color(0xFF0F0F0F),
                    fontSize: 20,
                    fontFamily: 'Gilroy',
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.56,
                  ),
                ),
                SizedBox(height: size.height*0.01,),
                Text("${com.market} Market", style: GoogleFonts.inter(
                  color: Color(0xFF4D4D4D),
                  fontSize: 14.30,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.36,
                ),)
              ],
            ),
            Column(
              children: [
                Text(
                  '₹${com.modalPrice}',
                  style: GoogleFonts.inter(
                    color: Color(0xFF458E62),
                    fontSize: 32.17,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -1.13,
                  ),
                ),
                SizedBox(height: size.height*0.005,),
                Text("Modal Price", style: GoogleFonts.inter(
                  color: Color(0xFF4D4D4D),
                  fontSize: 14.30,
                  fontWeight: FontWeight.w400,
                  letterSpacing: -0.36,
                ),)
              ],
            )
          ],
        ),
      ),
    );

  }
}
