class WorkModel {
  Location? location;
  String? sId;
  String? title;
  String? phone;
  String? district;
  String? price;
  num? iV;

  WorkModel(
      {this.location,
      this.sId,
      this.title,
      this.phone,
      this.district,
      this.price,
      this.iV});

  WorkModel.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : Location(
            type: 'Point',
            coordinates: [0.0, 0.0],
        );
    sId = json['_id'];
    title = json['title'];
    phone = json['phone'];
    district = json['district'];
    price = json['price'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['_id'] = this.sId;
    data['title'] = this.title;
    data['phone'] = this.phone;
    data['district'] = this.district;
    data['price'] = this.price;
    data['__v'] = this.iV;
    return data;
  }
}

class Location {
  String? type;
  List<num>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates'].cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
