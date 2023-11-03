import 'package:flutter/material.dart';

class WeatherModel {
  num? dt;
  List<Weather>? weather;
  Main? main;
  Wind? wind;
  Clouds? clouds;

  WeatherModel({this.dt, this.weather, this.main, this.wind, this.clouds});

  WeatherModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    clouds =
        json['clouds'] != null ? new Clouds.fromJson(json['clouds']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dt'] = this.dt;
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
    }
    if (this.clouds != null) {
      data['clouds'] = this.clouds!.toJson();
    }
    return data;
  }
}

class Weather {
  num? id;
  String? main;
  String? description;
  String? icon;
  String? image;
  Weather({this.id, this.main, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
    if(id! >= 200 && id! <= 232){
      image = 'assets/weather/def_thunder.svg';
    }
    else if(id! >= 300 && id! <= 321){
      image = 'assets/weather/def_rain.svg';
    }
    else if(id! >= 500 && id! <= 531){
      switch(id)
      {
        case 500: image = 'assets/weather/500.svg'; break;
        case 501: image = 'assets/weather/501.svg'; break;
        case 502: image = 'assets/weather/502.svg'; break;
        case 503: image = 'assets/weather/503.svg'; break;
        case 504: image = 'assets/weather/504.svg'; break;
        case 522: image = 'assets/weather/522.svg'; break;
        default: image = 'assets/weather/def_rain.svg'; break;
      }
    }
    else if(id! >= 600 && id! <= 622){
      switch(id)
      {
        case 601: image = 'assets/weather/601.svg'; break;
        case 602: image = 'assets/weather/602.svg'; break;
        case 611: image = 'assets/weather/611.svg'; break;
        case 612: image = 'assets/weather/612.svg'; break;
        case 613: image = 'assets/weather/613.svg'; break;
        default: image = 'assets/weather/def_snow.svg'; break;
      }
    }
    else if(id! >= 701 && id! <= 781){
      image = 'assets/weather/def_clear.svg';
    }
    else if(id == 800){
      image = 'assets/weather/def_clear.svg';
    }
    else if(id! >= 801 && id! <= 804){
      switch(id)
      {
        case 801: image = 'assets/weather/801.svg'; break;
        case 802: image = 'assets/weather/802.svg'; break;
        case 803: image = 'assets/weather/803.svg'; break;
        default: image = 'assets/weather/804.svg'; break;
      }
    }
    else{
      image = 'assets/weather/def_clear.svg';
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['main'] = this.main;
    data['description'] = this.description;
    data['icon'] = this.icon;
    return data;
  }
}

class Main {
  num? temp;
  num? feelsLike;
  num? tempMin;
  num? tempMax;
  num? pressure;
  num? humidity;

  Main(
      {this.temp,
      this.feelsLike,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity});

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    feelsLike = json['feels_like'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    data['feels_like'] = this.feelsLike;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    return data;
  }
}

class Wind {
  num? speed;
  num? deg;
  num? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    speed = json['speed'];
    deg = json['deg'];
    gust = json['gust'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['speed'] = this.speed;
    data['deg'] = this.deg;
    data['gust'] = this.gust;
    return data;
  }
}

class Clouds {
  num? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['all'] = this.all;
    return data;
  }
}
