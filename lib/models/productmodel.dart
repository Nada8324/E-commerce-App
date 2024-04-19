import '../shared/component/component.dart';

class EachCategoryModel{
  late bool status;
  EachCategoryDataModel? data;
  EachCategoryModel.fromjson(Map<String,dynamic>json){
    status = json['status'];
    if (status) {
      data = EachCategoryDataModel.fromjson(json['data']);
    }
  }

}
class EachCategoryDataModel{

  List<ProductsModel>? products=[];
  EachCategoryDataModel.fromjson(Map<String,dynamic>json){
    json['data'].forEach((element) {
      products?.add(ProductsModel.fromjson(element));
    });
  }
}