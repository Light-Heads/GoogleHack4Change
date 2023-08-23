class PolyStatsModel {
  double? std;
  double? p25;
  int? num;
  double? min;
  double? max;
  double? median;
  double? p75;
  double? mean;

  PolyStatsModel(
      {this.std,
      this.p25,
      this.num,
      this.min,
      this.max,
      this.median,
      this.p75,
      this.mean});

  PolyStatsModel.fromJson(Map<String, dynamic> json) {
    std = json['std'];
    p25 = json['p25'];
    num = json['num'];
    min = json['min'];
    max = json['max'];
    median = json['median'];
    p75 = json['p75'];
    mean = json['mean'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['std'] = this.std;
    data['p25'] = this.p25;
    data['num'] = this.num;
    data['min'] = this.min;
    data['max'] = this.max;
    data['median'] = this.median;
    data['p75'] = this.p75;
    data['mean'] = this.mean;
    return data;
  }
}
