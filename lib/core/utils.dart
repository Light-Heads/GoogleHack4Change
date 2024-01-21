import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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




String calculateHealth(BuildContext context, double NDVI)
{
  if(NDVI <0.0 || NDVI >=  0.2)
    {
      return AppLocalizations.of(context)!.low;
    }
  else if(NDVI <0.2 || NDVI >=  0.4)
  {
    return AppLocalizations.of(context)!.medium;
  }
  else if(NDVI <0.4 || NDVI >=  0.6)
  {
    return AppLocalizations.of(context)!.high;
  }
  else
    {
      return "High";
    }
}

String calculateWaterStress(BuildContext context,double NDWI, double  DSWI)
{
  double res = (NDWI + DSWI) / 2;
  if(res < 0.2)
  {
    return AppLocalizations.of(context)!.good;
  }
  else if(res <= 0.2 || res >= 0.5 )
  {
    return AppLocalizations.of(context)!.medium;
  }
  else if(res >= 0.5)
  {
    return AppLocalizations.of(context)!.high;
  }
  else
  {
    return AppLocalizations.of(context)!.high;
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