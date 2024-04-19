import 'package:flutter/material.dart';

class UserModel{
   late bool status;
  late String message;
  UserData ?data;
  UserModel.fromjson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message']??"succes";
    data=json['data']!=null?UserData.fromjson(json['data']):null;
  }
}
class UserData{
  int ?id;
  String ?name;
  String? email;
  String? phone;
  String? image;
  int? points;
  double?credit;
  String? token;
  UserData.fromjson(Map<String,dynamic>json){
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credit=json['credit'];
    token=json['token'];
  }
}