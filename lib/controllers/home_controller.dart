import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import '../models/HomeModel.dart';
import '../models/category_model.dart';
import '../shared/component/component.dart';
import '../shared/network/end_points.dart';
import '../shared/network/remote/diohelper.dart';
import '../view/DetailsScreen.dart';
import '../view/EachCategoryScreen.dart';
import 'Layout_controller.dart';

class HomeController extends GetxController{

  LayoutController layoutController=Get.put(LayoutController());
  var search_controller=TextEditingController();
  CategoryModel ?categoryModel;
  HomeModel ?homeModel;
  List<DataModel> categoryitemlist=[];
  List<ProductsModel>prductItemList=[];
  late bool discount;
  @override
  void onInit()async {
    // TODO: implement onInit
    super.onInit();
      await DioHelper.getData(url: Categories).then((value) {
       categoryModel=CategoryModel.Fromjson(value.data);
       categoryitemlist=categoryModel!.data!.data!;
     }).then((value) {
       update();
     });
     await DioHelper.getData(url: Home,token: token
     ).then((value) {
       homeModel=HomeModel.fromjson(value.data);
       prductItemList=homeModel!.data!.products!;
     }).then((value) {
       update();
     });

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
  Widget build_category_item(DataModel model){
    return InkWell(
      onTap: () {
        Get.to(()=>EachCategoryScreen(),arguments: [model.id,model.name,model.image]);
      },
      child: Container(
        height: 60.h,
        width: 140.w,
        decoration: BoxDecoration(
          color: HexColor("#F5F6FA"),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image(image: NetworkImage("${model.image}"),
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    else {
                      return Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    }
                  }
               ),
              ),
            ),
            SizedBox(
              width: 10.h,
            ),
            Text('${model.name}',style: GoogleFonts.inter(
                color: HexColor("#1D1E20"),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
            ),)
          ],
        ),
      ),
    );
  }
  void changeindex(int index){
    layoutController.index=index;
    update();
    layoutController.update();
   }

}