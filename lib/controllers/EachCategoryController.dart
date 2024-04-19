import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';


import '../models/HomeModel.dart';
import '../models/productmodel.dart';
import '../shared/component/component.dart';
import '../shared/network/end_points.dart';
import '../shared/network/remote/diohelper.dart';
import '../shared/styles/icon_broken.dart';
import '../view/DetailsScreen.dart';
import 'Layout_controller.dart';

class EachCategoryController extends GetxController {
 int id=Get.arguments[0];
 String name=Get.arguments[1];
 String image=Get.arguments[2];
 LayoutController layoutController=Get.put(LayoutController());
 EachCategoryModel ?Model;
 var search_controller=TextEditingController();
 @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
   await DioHelper.getData(url: Products,query: {
      'category_id':id
    },token: token
    ).then((value) {
     Model=EachCategoryModel.fromjson(value?.data);
     update();
   });
  }
 void changeindex(int index){
   layoutController.index=index;
   update();
   layoutController.update();
 }
 Widget BuildProductItem(ProductsModel model){
   bool? fav=model.in_favorites;
   return Container(
     color: Colors.white,
     child: InkWell(
       onTap: () {
         Get.to(()=>DetailsScreen(),arguments: [model]);
       },
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Stack(
             children: [
               Image(image: NetworkImage(
                   "${model.image}"
               ),
                 height: 203.h,
                 width: 160.w,
                   loadingBuilder: (context, child, loadingProgress) {
                     if (loadingProgress == null) {
                       return child;
                     }
                     else {
                       return Container(
                         height: 203.h,
                         width: 160.w,
                         child: Center(
                           child: CircularProgressIndicator(color: Colors.black),
                         ),
                       );
                     }
                   }
               ),
               InkWell(
                 onTap: () {

                   changefavourite(model.id);

                   model.in_favorites=!model.in_favorites!;
                   update();
                 },
                 child: model.in_favorites!?Icon(Iconsax.heart5):Icon(Iconsax.heart),
               ),

             ],
           ),
           SizedBox(
             height: 5.h,
           ),
           Container(
             height: 35,
             child: Text('${model.name}',style: GoogleFonts.inter(
               fontWeight: FontWeight.w500,
               fontSize: 11.sp,
               color: HexColor("#1D1E20"),
             ),maxLines: 2,overflow: TextOverflow.ellipsis),
           ),
           Row(
             children: [
               Text('${model.price}',style: GoogleFonts.inter(
                 fontWeight: FontWeight.w600,
                 fontSize: 13.sp,
                 color: HexColor("#1D1E20"),
               )),
               if(model.price!=model.old_price)
                 SizedBox(width: 5.w,),
               if(model.price!=model.old_price)
                 Text(
                   '${model.old_price}', style: GoogleFonts.inter(
                     color: HexColor("#8F959E"),
                     fontSize: 12.sp,
                     decoration: TextDecoration.lineThrough
                 ),),
               if(model.price!=model.old_price)
                 Spacer(),
               if(model.price!=model.old_price)
                 Text(
                   '${model.discount}%', style: GoogleFonts.inter(
                   color: Colors.green,
                   fontSize: 13.sp,

                 ),),

             ],
           ),

         ],
       ),
     ),
   );
 }
}
