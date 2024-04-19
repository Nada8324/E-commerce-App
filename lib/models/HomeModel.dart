import 'dart:convert';

import '../shared/component/component.dart';

class HomeModel{
  late bool status;
  HomeDataModel? data;
  HomeModel.fromjson(Map<String,dynamic>json){
    status = json['status'];
    if (status) {
      data = HomeDataModel.fromjson(json['data']);
    }
  }

}
class HomeDataModel{

  List<ProductsModel>? products=[];
  HomeDataModel.fromjson(Map<String,dynamic>json){
   json['products'].forEach((element) {
     products?.add(ProductsModel.fromjson(element));
   });
  }
}
