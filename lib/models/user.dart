class UserModel {
  String? name;
  String? phone;
  String? role;
  String? userId;
  String? verificationId;
  List<num>? location;
  String? polygonId;
  String? district;
  String? city;
  String? state;
  String? locality;
  String? image;

  UserModel(
      {this.name,
      this.phone,
      this.role,
      this.userId,
      this.verificationId,
      this.location,
      this.polygonId,
      this.district,
      this.city,
      this.state,
      this.locality,
      this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    role = json['role'];
    userId = json['userId'];
    verificationId = json['verificationId'];
    if(json['location'] != null){
      location = json['location'].cast<num>();
    }else{
      location = [0,0];
    }
    polygonId = json['polygonId'];
    district = json['district'];
    city = json['city'];
    state = json['state'];
    locality = json['locality'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['role'] = this.role;
    data['userId'] = this.userId;
    data['verificationId'] = this.verificationId;
    data['location'] = this.location;
    data['polygonId'] = this.polygonId;
    data['district'] = this.district;
    data['city'] = this.city;
    data['state'] = this.state;
    data['locality'] = this.locality;
    data['image'] = this.image;
    return data;
  }
}
