import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

void showSnackBar(BuildContext context, String content) {
  try {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  } catch (e) {
    if (kDebugMode) {
      print(content);
    }
  }
}




String calculateHealth(double NDVI)
{
  if(NDVI <0.0 || NDVI >=  0.2)
    {
      return "Low";
    }
  else if(NDVI <0.2 || NDVI >=  0.4)
  {
    return "Medium";
  }
  else if(NDVI <0.4 || NDVI >=  0.6)
  {
    return "High";
  }
  else
    {
      return "High";
    }
}

String calculateWaterStress(double NDWI, double  DSWI)
{
  double res = (NDWI + DSWI) / 2;
  if(res < 0.2)
  {
    return "Good";
  }
  else if(res <= 0.2 || res >= 0.5 )
  {
    return "Medium";
  }
  else if(res >= 0.5)
  {
    return "High";
  }
  else
  {
    return "High";
  }
}

String calculateNitrogen(double NRI)
{
  if(NRI <= 0.2 )
    {
      return "Low";
    }
  else if(NRI >0.2)
    {
      return "High";
    }
  else
    {
      return "Decent";
    }
}