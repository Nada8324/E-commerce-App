import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import '../models/GetFavoriteModel.dart';
import '../shared/component/component.dart';
import '../shared/network/end_points.dart';
import '../shared/network/remote/diohelper.dart';
import '../shared/styles/icon_broken.dart';
import '../view/DetailsScreen.dart';
import 'Layout_controller.dart';

class GetFav extends GetxController {
  @override
  LayoutController layoutController = Get.put(LayoutController());
  GetFavModel ?getFavModel;
  bool fav = true;

  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await DioHelper.getData(url: FAVORITE,
      token: token,
    ).then((value) {
      getFavModel = GetFavModel.fromJson(value.data);
    }).then((value) {
      update();
    }
    );
  }

  void changeindex(int index) {
    layoutController.index = index;
    update();
    layoutController.update();
  }
  List<FavData> product_list_deleted=[];
  Widget BuildFavItem(FavData model) {
    return Dismissible(
      direction: DismissDirection.endToStart,
       key: Key(model.product!.id!.toString()),
      onDismissed: (direction){
        changefavourite(model.product!.id);
        // update();
        //  product_list_deleted=[];
        getFavModel!.data!.data?.forEach((element) {
          if(element.id==model.id)
          {

          }
          else{
            product_list_deleted.add(element);
          }
          update();
        });
        getFavModel!.data!.data=product_list_deleted;
        update();
      },
      background: Container(
        width: double.infinity,
        color: Colors.white,
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: Icon(Iconsax.heart_remove),
        ),
      ),
      child: Container(
        height: 120.h,
        padding: EdgeInsetsDirectional.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 20.r,

              offset: Offset(4, 8), // Shadow position
            ),
          ],
          color: HexColor("#FEFEFE"),
        ),

        child: InkWell(
          onTap: () {
            Get.to(()=>DetailsScreen(),arguments: [model.product]);
          },
          child: Row(

            children: [
              Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                width: 100.w,
                //height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r)
                ),
                child: Image(image: NetworkImage(model.product!.image!),

                  //fit: BoxFit.scaleDown,
                  loadingBuilder:(context, child, loadingProgress)  {
                    if(loadingProgress==null){
                      return child;
                    }
                    else{
                      return Center(
                        child: CircularProgressIndicator(color: Colors.black),
                      );
                    }
                  },),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.h,),
                      Container(
                        width: 137.w,
                        child: Text(
                          model.product!.name!,
                          style:GoogleFonts.inter(
                            color:  HexColor("#1D1E20"),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,

                          overflow: TextOverflow.ellipsis,),
                      ),
                      Spacer(),
                      //SizedBox(height: 20.h,),
                      Row(
                        children: [
                          Text('\$${model.product!.price}(+${(model.product!.price*0.02).round()} Tax)',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                                fontSize: 11.sp,
                                color: HexColor("#8F959E"),
                              )),
                          Spacer(),
                          InkWell(
                            child: Container(
                              width: 25.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: HexColor("#DEDEDE")
                                  )
                              ),
                              child: Icon(IconBroken.Delete,size: 15,color: HexColor("#8F959E")),

                            ),
                            onTap: () {
                              changefavourite(model.product!.id);
                              getFavModel?.data?.data?.remove(model);
                              update();
                            },
                          )
                        ],
                      ),
                      SizedBox(height: 6.h,)



                    ],

                  ),
                ),
              ),
              // Icon(IconBroken.Bookmark)

            ],

          ),

        ),
      ),
    );
  }
}