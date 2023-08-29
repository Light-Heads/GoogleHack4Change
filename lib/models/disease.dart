class DiseaseModel {
  double? accuracy;
  String? img;
  String? name;
  String? soln;

  DiseaseModel({this.accuracy, this.img, this.name, this.soln});

  DiseaseModel.fromJson(Map<String, dynamic> json) {
    accuracy = json['accuracy'];
    img = json['img'];
    name = json['name'];
    soln = json['soln'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accuracy'] = this.accuracy;
    data['img'] = this.img;
    data['name'] = this.name;
    data['soln'] = this.soln;
    return data;
  }
}
