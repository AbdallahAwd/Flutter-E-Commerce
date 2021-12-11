  class FavoritesModel {
  bool status;
  Data data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }


}

class Data {
  int currentPage;
  List<FavoritesData> data;


  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = new List<FavoritesData>();
      json['data'].forEach((v) {
        data.add(new FavoritesData.fromJson(v));
      });
    }

  }

}

class FavoritesData {
  int id;
  Product product;



  FavoritesData.fromJson(Map<String, dynamic> json) {
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
