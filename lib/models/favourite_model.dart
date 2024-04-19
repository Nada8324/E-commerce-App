class FavoriteModel{
  late bool status;
  String? message;
  FavoriteModel.Fromjson(Map<String,dynamic>json){
      status=json['status'];
      message=json['message'];
  }
}

class UpdateCartModel{
  late bool status;
  String? message;
  UpdateCartModel.Fromjson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];
  }
}