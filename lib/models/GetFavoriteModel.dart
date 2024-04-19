
import '../shared/component/component.dart';

class GetFavModel {
  bool? status;
  String? message;
  Data? data;

  GetFavModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] =  Data.fromJson(json['data']);
  }
}

class Data {
  List<FavData>? data=[];
  int? total;


  Data.fromJson(Map<String, dynamic> json) {

      json['data'].forEach((v) {
        data?.add( FavData.fromJson(v));
      });

    total = json['total'];
  }
}

class FavData {
  late int id;
  ProductsModel? product;

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] =ProductsModel.fromjson(json['product']);
  }

}