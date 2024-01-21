class ProductModel {
  String? title;
  String? userId;
  String? phone;
  String? description;
  String? price;
  String? brand;
  String? imageURL;

  ProductModel({
    this.title,
    this.userId,
    this.phone,
    this.description,
    this.price,
    this.brand,
    this.imageURL,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    userId = json['userId'];
    phone = json['phone'];
    description = json['description'];
    price = json['price'];
    brand = json['brand'];
    imageURL = json['imageURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['userId'] = userId;
    data['phone'] = phone;
    data['description'] = description;
    data['price'] = price;
    data['brand'] = brand;
    data['imageURL'] = imageURL;
    return data;
  }
}
