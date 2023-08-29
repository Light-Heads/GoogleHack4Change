// To parse this JSON data, do
//
//     final polygon = polygonFromMap(jsonString);

import 'dart:convert';

PolygonModel polygonFromMap(String str) => PolygonModel.fromMap(json.decode(str));

String polygonToMap(PolygonModel data) => json.encode(data.toMap());

class PolygonModel {
    String? id;
    GeoJson? geoJson;
    String? name;
    List<double>? center;
    double? area;
    String? userId;
    int? createdAt;

    PolygonModel({
        this.id,
        this.geoJson,
        this.name,
        this.center,
        this.area,
        this.userId,
        this.createdAt,
    });

    factory PolygonModel.fromMap(Map<String, dynamic> json) => PolygonModel(
        id: json["id"],
        geoJson: GeoJson.fromMap(json["geo_json"]),
        name: json["name"],
        center: List<double>.from(json["center"].map((x) => x.toDouble())),
        area: json["area"].toDouble(),
        userId: json["user_id"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "geo_json": geoJson!.toMap(),
        "name": name,
        "center": List<dynamic>.from(center!.map((x) => x)),
        "area": area,
        "user_id": userId,
        "created_at": createdAt,
    };
}

class GeoJson {
    String? type;
    Properties? properties;
    Geometry? geometry;

    GeoJson({
        this.type,
        this.properties,
        this.geometry,
    });

    factory GeoJson.fromMap(Map<String, dynamic> json) => GeoJson(
        type: json["type"],
        properties: Properties.fromMap(json["properties"]),
        geometry: Geometry.fromMap(json["geometry"]),
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "properties": properties!.toMap(),
        "geometry": geometry!.toMap(),
    };
}

class Geometry {
    String? type;
    List<List<List<double>>>? coordinates;

    Geometry({
        this.type,
        this.coordinates,
    });

    factory Geometry.fromMap(Map<String, dynamic> json) => Geometry(
        type: json["type"],
        coordinates: List<List<List<double>>>.from(json["coordinates"].map((x) => List<List<double>>.from(x.map((x) => List<double>.from(x.map((x) => x.toDouble())))))),
    );

    Map<String, dynamic> toMap() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => List<dynamic>.from(x.map((x) => List<dynamic>.from(x.map((x) => x)))))),
    };
}

class Properties {
    Properties();

    factory Properties.fromMap(Map<String, dynamic> json) => Properties(
    );

    Map<String, dynamic> toMap() => {
    };
}
