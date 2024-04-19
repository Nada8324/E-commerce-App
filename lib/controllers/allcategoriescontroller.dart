import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

import '../models/category_model.dart';
import '../shared/network/end_points.dart';
import '../shared/network/remote/diohelper.dart';
import '../view/EachCategoryScreen.dart';
import 'Layout_controller.dart';
import 'home_controller.dart';

class AllCategoriesController extends GetxController{
  List<DataModel>list=Get.arguments[0];
  LayoutController layoutController=Get.put(LayoutController());
  @override
  Widget BuildCategoryItem(DataModel model){
    return Container(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20)
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(image: NetworkImage("${model.image}"),
              fit: BoxFit.cover,

            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text('${model.name}',style: GoogleFonts.inter(
            color: HexColor("#1D1E20"),
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),),
          Spacer(),
          InkWell(
              onTap: () {
                Get.to(()=>EachCategoryScreen(),arguments: [model.id,model.name,model.image]);
              },child: Icon(Iconsax.arrow_right_3)),
        ],
      ),
    );
  }
  void changeindex(int index){
    layoutController.index=index;
    update();
    layoutController.update();
  }
}