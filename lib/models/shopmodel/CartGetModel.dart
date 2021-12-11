class GetCartModel {
  bool status;
  Data data;

  GetCartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  int id;
  List<CartData> data;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['data'] != null) {
      data = new List<CartData>();
      json['data'].forEach((v) {
        data.add(new CartData.fromJson(v));
      });
    }

  }

}

class CartData {
  int id;
  Product product;



  CartData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }


}

class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;
  String description;


  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
