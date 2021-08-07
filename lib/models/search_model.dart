class SearchModel{
  bool? status;
  SearchDataModel? data;
  SearchModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=SearchDataModel.fromJson(json['data']);
  }
}


class SearchDataModel{
  int? currentPage;
  List<Product>? data=[];

  SearchDataModel.fromJson(Map<String, dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element) {
      data!.add(Product.fromJson(element));
    });
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