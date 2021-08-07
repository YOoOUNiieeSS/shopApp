class FavoritesModel{
  bool? status;
  FavoritesDataModel? data;
  FavoritesModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=FavoritesDataModel.fromJson(json['data']);
  }
}


class FavoritesDataModel{
  int? currentPage;
  List<Data>? data=[];

  FavoritesDataModel.fromJson(Map<String, dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element) {
      data!.add(Data.fromJson(element));
    });
  }
}

class Data{
  int? id;
  Product? product;
  Data.fromJson(Map<String, dynamic> json){
    id=json['id'];
    product=Product.fromJson(json['product']);
  }
}

class Product{
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String?  image;
  String? name;
  String? description;
  Product.fromJson(Map<String, dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    description=json['description'];
    name=json['name'];
  }
}