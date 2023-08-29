class SoilMoistureModel {
  int? dt;
  double? t10;
  double? moisture;
  double? t0;

  SoilMoistureModel({this.dt, this.t10, this.moisture, this.t0});

  SoilMoistureModel.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    t10 = json['t10'];
    moisture = json['moisture'];
    t0 = json['t0'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['dt'] = dt;
    data['t10'] = t10;
    data['moisture'] = moisture;
    data['t0'] = t0;
    return data;
  }
}
