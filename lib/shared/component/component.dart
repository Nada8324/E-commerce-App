import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../../models/HomeModel.dart';
import '../../models/cart_item_model.dart';
import '../../models/favourite_model.dart';
import '../network/end_points.dart';
import '../network/remote/diohelper.dart';
import '../styles/icon_broken.dart';

Widget CircleButton(IconData iconData,final Function()? onPressed){
  return  InkWell(
    splashColor: Colors.transparent,
    highlightColor:  Colors.transparent,
    onTap:onPressed,
    child: CircleAvatar(
      radius: 22.5.r,
      backgroundColor: HexColor("#F5F6FA"),
      child: Icon(iconData,color: HexColor("#1D1E20")),
    ),
  );
}

Widget text_form({
  required TextEditingController controller,
  //required Function validate,
  required String label,
  required Widget suffix,
  required TextInputType type,
  required Validators validators,
}){
  return  TextFormField(
  controller: controller,
  style: GoogleFonts.inter(
  fontSize: 15.sp,
  fontWeight: FontWeight.w500,
  color: HexColor("#1D1E20"),
  ),
  validator: Validators.compose([
  Validators.required('Email Adress is required'),
  Validators.email('Invalid Email Adress')
  ]
  ),
  keyboardType:type ,

  decoration: InputDecoration(

  label: Text(
  label,
  style: GoogleFonts.inter(
  fontSize: 13.sp,
  fontWeight: FontWeight.w400,
  color: HexColor("#8F959E"),
),
),
  suffix: suffix,
  suffixIconColor: HexColor("#4A4E69"),
   suffixStyle: GoogleFonts.inter(
     fontSize: 13.sp,
      fontWeight: FontWeight.w400,
      color: HexColor("#8F959E"),

    ),

),

);
}
void printfulltext(String text){
  final pattern=RegExp('.{1.800}');
  pattern.allMatches(text).forEach((match) { print(match.group(0));});
}
String? token;
FavoriteModel ?favoriteModel;
CartModel? cartModel;
void changefavourite(int id){
  DioHelper.postData(url: FAVORITE, data: {
    'product_id':id
  },
      token: token
  ).then((value) {
    favoriteModel=FavoriteModel.Fromjson(value.data);
    print(favoriteModel?.message);
  });
}
void changecart(int id){
  DioHelper.postData(url: CARTS, data: {
    'product_id':id
  },
      token: token
  ).then((value) {
    cartModel=CartModel.fromJson(value.data);
    print(cartModel?.message);
  });
}
const IconData check_circle_rounded = IconData(0xf635, fontFamily: 'MaterialIcons');
class ProductsModel{
  late int id;
  dynamic? price;
  dynamic? old_price;
  dynamic? discount;
  String? image;
  String? name;
  String? description;
  List<dynamic>?images;
  bool? in_favorites=false;
  bool? in_cart;
  ProductsModel.fromjson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'];
    old_price=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    images=json['images'];
    description=json['description'];
    in_favorites=json['in_favorites'];
    in_cart=json['in_cart'];
  }
}
Widget DetailsOfCart({required String text1,required String text2}){
  return  Row(
    children: [
      Text("${text1}",style: GoogleFonts.inter(
        color: HexColor('#8F959E'),
        fontWeight: FontWeight.w400,
        fontSize: 15.sp,

      ),),
      Spacer(),
      Text("\$${text2}",style: GoogleFonts.inter(
        color: HexColor('#1D1E20'),
        fontWeight: FontWeight.w500,
        fontSize: 15.sp,

      ),
      ),
    ],
  );
}
Widget rowofsetting({required String text,required IconData icon,required Function() function}){
  return Row(
  children: [
  Icon(icon,
color: HexColor("#1D1E20"),
size: 25,
),
    SizedBox(
      width: 10.w,
    ),
InkWell(
  onTap: function,
  child:   Text("${text}",
  style: GoogleFonts.inter(
  fontWeight: FontWeight.w400,
  fontSize: 15.sp,
  color: HexColor("#1D1E20")
  ),),
)
],
);
}