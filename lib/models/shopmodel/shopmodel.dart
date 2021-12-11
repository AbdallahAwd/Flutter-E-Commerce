class ShopLoginModel
{
  bool status;
  String message;
  UserDate data;
  ShopLoginModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDate.fromJson(json['data']) : null;
  }
}
class RegisterModel
{
  bool status;
  String message;
  UserDate data;
  RegisterModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserDate.fromJson(json['data']) : null;
  }
}
class UserDate
{
  int id;
  String name;
  String email;
  String phone;
  String image;
  int points;
  int credit;
  String token;

  UserDate.fromJson(Map<String , dynamic> json)
  {
   id = json['id'];
   name = json['name'];
   email = json['email'];
   phone = json['phone'];
   image = json['image'];
   points = json['points'];
   credit = json['credit'];
   token = json['token'];
  }
}