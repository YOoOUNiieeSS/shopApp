class ShopLoginModel
{
  String? message;
  bool? status;
  UserData? data;
  ShopLoginModel.fromJson(Map<String,dynamic> json)
  {
    message=json['message'];
    status=json['status'];
    if(json['data']!=null)
     data= UserData.fromJson(json['data']);
  }
}

class UserData
{
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? token;
  int? points;
  int? credit;
  UserData.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    token=json['token'];
    points=json['points'];
    credit=json['credit'];
  }
}