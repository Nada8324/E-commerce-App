class CategoryModel{
  bool ?status;
  CategoryDetails ?data;
  CategoryModel.Fromjson(Map<String,dynamic>json){
    status=json['status'];
    data=CategoryDetails.Fromjson(json['data']);
  }
}
class CategoryDetails{
  int? current_page;
  List<DataModel>? data=[];
  CategoryDetails.Fromjson(Map<String,dynamic>json){
    current_page=json['current_page'];
    json['data'].forEach((element){
      data?.add(DataModel.Fromjson(element));
    });
  }

}
class DataModel{
  int? id;
  String? name;
  String? image;
  DataModel.Fromjson(Map<String,dynamic> json){
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}