import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import '../models/cart_item_model.dart';
import '../shared/component/component.dart';
import '../shared/network/end_points.dart';
import '../shared/network/remote/diohelper.dart';
import '../shared/styles/icon_broken.dart';
import '../view/DetailsScreen.dart';
import 'Layout_controller.dart';

class CartController extends GetxController{
@override
double totalprice=0;
CartModel ? cartModel;

  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    await DioHelper.getData(url: CARTS,
      token: token,
    ).then((value) {
      cartModel = CartModel.fromJson(value.data);
    }).then((value) {
      update();
    }
    );
  }

  Widget builditem(CartItems model,int index){
    return Container(
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
        color: index==0?HexColor("#FEFEFE"):HexColor("#F5F6FA"),
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

                //fit: BoxFit.cover,
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
                    SizedBox(height: 10.h,),
                    Text('\$${model.product!.price}(+${(model.product!.price*0.02).round()} Tax)',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 11.sp,
                      color: HexColor("#8F959E"),
                    )),
                    
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(

                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: HexColor("#DEDEDE")
                                  )
                              ),
                              child: Icon(IconBroken.Arrow___Down_2,color: HexColor("#8F959E")),


                            ),
                            onTap: () {
                              model.quantity=model.quantity!-1;
                              if(model.quantity==0){
                                cartModel?.data?.cartItems?.remove(model);
                              }
                              update();
                            },
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text('${model.quantity}',style: GoogleFonts.inter(
                            color: HexColor("#1D1E20"),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          InkWell(

                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: HexColor("#DEDEDE")
                                  )
                              ),
                              child: Icon(IconBroken.Arrow___Up_2,color: HexColor("#8F959E")),

                            ),
                            onTap: () {
                              model.quantity=model.quantity!+1;
                              update();
                            },
                          ),
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
                              changecart(model.product!.id);
                              cartModel?.data?.cartItems?.remove(model);
                              update();
                            },
                          )
                        ],
                      ),
                    ),
                    //     maxLines: 3),
                  ],

                ),
              ),
            ),
            // Icon(IconBroken.Bookmark)

          ],

        ),

      ),
    );

  }

LayoutController layoutController=Get.put(LayoutController());

void changeindex(int index){
  layoutController.index=index;
  update();
  layoutController.update();
}
  int calctotal(){
    cartModel?.data?.cartItems?.forEach((model) {
      totalprice+=model.quantity!*(model.product?.price+model.product?.price*0.02);

    });
    return totalprice.round();
  }
}