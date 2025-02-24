
class UserModel{
  String ?uId;
  String ?name;
  String? email;
  String? phone;
  bool? isverefied;
  String?image;
  String?coverimage;
  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.image,
    this.isverefied,
    this.coverimage ,
  });
  UserModel.fromjson(Map<String,dynamic>json){
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    uId=json['uId'];
    image=json['image'];
    coverimage=json['coverimage'];
    isverefied=json['isverefied'];
  }
  Map<String,dynamic> toMap()
  {
    return{
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'image':image,
      'coverimage':coverimage,
      'isverefied':isverefied,
    };
  }
}