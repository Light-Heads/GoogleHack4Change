// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:frontend/models/weather.dart';

import '../../theme.dart';
import 'package:intl/intl.dart';
Widget WeatherCard(size, WeatherModel weather,)
{
  var unixDate = weather.dt!.toInt();
  var dt = DateTime.fromMillisecondsSinceEpoch(unixDate * 1000);
  var day = DateFormat('EEEE').format(dt).toString();
  var month = DateFormat('d MMM').format(dt).toString();
  var year = DateFormat('yyyy').format(dt).toString();
  var hour = DateFormat('HH:mm').format(dt).toString();
 return Padding(
   padding: const EdgeInsets.all(18.0),
   child: Container(

     width: size.width*0.84,
     height : size.height*0.14,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3FACACAC),
            blurRadius: 26,
            offset: Offset(0, 19),
            spreadRadius: 0,
          )
        ],
      ),

     child: Padding(
       padding: const EdgeInsets.all(18.0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(day, style: sub1.copyWith(fontWeight: FontWeight.w600, color: Colors.black),),
              SizedBox(height: size.height*0.01,),
              Text('$month $year', style: sub1.copyWith(fontSize: 12),),
              SizedBox(height: size.height*0.01,),
              Text("Time: $hour", style: sub1.copyWith(fontSize: 12),)
            ],
          ),
          Column(
            children: [
              Text('${weather.main!.temp.toString()}°', style: h1,),
              SizedBox(height: size.height*0.01,),
              Text(weather.weather![0].description
                  .toString(),)
            ],
          ),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color(0x3FACACAC),
                      blurRadius: 34,
                      offset: Offset(0, 9),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Image.network(
                  'https://openweathermap.org/img/wn/${weather.weather![0].icon}@2x.png',
                  scale: 2,
                ),
              ),
              ],
          ),

        ],
       ),
     ),
    ),
 );
}