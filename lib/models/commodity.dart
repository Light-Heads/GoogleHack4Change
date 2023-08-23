class CommodityModel {
  List<Records>? records;

  CommodityModel({this.records});

  CommodityModel.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <Records>[];
      json['records'].forEach((v) {
        records!.add(new Records.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Records {
  String? state;
  String? district;
  String? market;
  String? commodity;
  String? variety;
  String? grade;
  String? arrivalDate;
  String? minPrice;
  String? maxPrice;
  String? modalPrice;

  Records(
      {this.state,
      this.district,
      this.market,
      this.commodity,
      this.variety,
      this.grade,
      this.arrivalDate,
      this.minPrice,
      this.maxPrice,
      this.modalPrice});

  Records.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    district = json['district'];
    market = json['market'];
    commodity = json['commodity'];
    variety = json['variety'];
    grade = json['grade'];
    arrivalDate = json['arrival_date'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    modalPrice = json['modal_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    data['district'] = this.district;
    data['market'] = this.market;
    data['commodity'] = this.commodity;
    data['variety'] = this.variety;
    data['grade'] = this.grade;
    data['arrival_date'] = this.arrivalDate;
    data['min_price'] = this.minPrice;
    data['max_price'] = this.maxPrice;
    data['modal_price'] = this.modalPrice;
    return data;
  }
}
