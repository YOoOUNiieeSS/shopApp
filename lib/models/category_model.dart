class CategoryModel{
  bool? status;
  CategoryDataModel? data;

  CategoryModel.fromJson(Map<String, dynamic> json){
    status=json['status'];
    data=CategoryDataModel.fromJson(json['data']);
  }
}

class CategoryDataModel{
  List<DataModel> data=[];
  int? currentPage;

  CategoryDataModel.fromJson(Map<String, dynamic> json){
    currentPage=json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel{
  int? id;
  String? image;
  String? name;

  DataModel.fromJson(Map<String, dynamic> json){
    id=json['id'];
    image=json['image'];
    name=json['name'];
  }
}