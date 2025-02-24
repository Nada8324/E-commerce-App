import 'dart:convert';

import '../../../shared/component/component.dart';

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

/*model for another api
class HomeModel {
   int? id;
   String? title;
   double? price;
   String? description;
   String? category;
   String? image;
   Rating? rating;
      HomeModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
     title = json['title'];
     price = json['price'];
     description = json['description'];
     category = json['category'];
     image = json['image'];
     rating = json['rating'] != null ? new Rating.fromJson(json['rating']) : null;
   }
 }
 class Rating {
   double? rate;
   int? count;
//   Rating.fromJson(Map<String, dynamic> json) {
     rate = json['rate'];
     count = json['count'];
//   }
// }*/
