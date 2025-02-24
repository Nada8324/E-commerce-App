import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
    /*return GetBuilder<CartController>(
      init: CartController(),
      builder: (controller) {
        if(controller.cartModel?.data==null)
        {
          return Container(
            color: Colors.white,
            child: Center(child: CircularProgressIndicator(color: Colors.black,)),
          );
        }
        if(controller.cartModel?.data?.cartItems?.length==0){
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(

                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor:  Colors.transparent,
                          onTap:() {
                            Get.back();
                          },
                          child: CircleAvatar(
                            radius: 22.5.r,
                            backgroundColor: HexColor("#F5F6FA"),
                            child: Icon(Iconsax.arrow_left
                                ,color: HexColor("#1D1E20")),
                          ),
                        ),
                        SizedBox(
                          width: 104.w,
                        ),
                        Text(
                          'Cart',style: GoogleFonts.inter(
                          color: HexColor("#1D1E20"),
                          fontWeight: FontWeight.w600,
                          fontSize: 17.sp,
                        ),
                        )
                      ],
                    ),

                   Image(image: AssetImage("assets/images/54b13147340145.Y3JvcCw0MDUsMzE3LDAsNDI.png")),
                    Text("Your cart is empty",style: GoogleFonts.inter(
                       color: HexColor("#4A4E69"),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600
                    ),),
                    SizedBox(height: 20.h,),
                    InkWell(
                      onTap: () {
                        controller.changeindex(0);
                        Get.to(LayoutScreen(),transition:Transition.leftToRight );
                        controller.update();
                        print("jhgffghj");
                      },
                      child: Container(
                        height: 48.h,
                        decoration: BoxDecoration(
                            color: HexColor("#4A4E69"),
                            borderRadius: BorderRadius.circular(6.r)
                        ),
                        child: Center(
                          child: Text("Continue Shopping",style: GoogleFonts.inter(
                            color: Colors.white,

                          )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0).h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        splashColor: Colors.transparent,
                        highlightColor:  Colors.transparent,
                        onTap:() {
                          Get.back();
                        },
                        child: CircleAvatar(
                          radius: 22.5.r,
                          backgroundColor: HexColor("#F5F6FA"),
                          child: Icon(Iconsax.arrow_left
                              ,color: HexColor("#1D1E20")),
                        ),
                      ),
                      SizedBox(
                        width: 104.w,
                      ),
                      Text(
                        'Cart',style: GoogleFonts.inter(
                        color: HexColor("#1D1E20"),
                        fontWeight: FontWeight.w600,
                        fontSize: 17.sp,
                      ),
                      )
                    ],
                  ),
                  SizedBox(
                      height: 25.h),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: Container(
                       height: controller.cartModel!.data!.cartItems?.length==1?120.h:260.h,
                      child: ListView.separated(itemBuilder: (context,index) {
                        return controller.builditem(controller.cartModel!.data!.cartItems![index],index);
                      },
                          separatorBuilder: (context, index) {
                       return  SizedBox(
                           height: 20.h,
                          );
                        },itemCount:controller.cartModel!.data!.cartItems!.length ),
                    ),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Text('Delivery Address',style: GoogleFonts.inter(
                        color: HexColor('#1D1E20'),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,

                      ),),
                      Spacer(),
                      Icon(Iconsax.arrow_right_3,color: HexColor("#1D1E20")),

                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r)
                        ),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            Image(
                              image: AssetImage("assets/images/Rectangle 584.png"
                          ),
                          ),
                            CircleAvatar(
                              backgroundColor: HexColor("#3D93F8"),
                              radius: 10.r,
                              child: Icon(
                                Iconsax.location,
                                color: Colors.white,
                                size: 15.h,
                              ),
                            )
                          ]
                        ),

                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text('Chhatak, Sunamgonj 12/8AB',style:
                         GoogleFonts.inter(
                           color: HexColor("#1D1E20"),
                           fontSize: 15.sp,
                           fontWeight: FontWeight.w400,
                         ),
                         ),
                         SizedBox(
                           height: 10.h,
                         ),
                         Text("Sylhet",style: GoogleFonts.inter(
                           fontWeight: FontWeight.w400,
                           fontSize: 13.sp,
                           color: HexColor("#8F959E"),
                         ),)
                       ], 
                      ),
                      Spacer(),
                      Icon(
                        check_circle_rounded,
                        size: 25.r,
                        color: HexColor("#4A4E69"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Text('Payment Method',style: GoogleFonts.inter(
                        color: HexColor('#1D1E20'),
                        fontWeight: FontWeight.w500,
                        fontSize: 17.sp,

                      ),),
                      Spacer(),
                      Icon(Iconsax.arrow_right_3,color: HexColor("#1D1E20")),

                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          color: HexColor("#F5F6FA"),
                        ),
                        child: Image(image: AssetImage("assets/images/Visar.png"
                        ),
                        ),

                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Visa Classic',style:
                          GoogleFonts.inter(
                            color: HexColor("#1D1E20"),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          Text("**** 7690",style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp,
                            color: HexColor("#8F959E"),
                          ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        check_circle_rounded,
                        size: 25,
                        color: HexColor("#4A4E69"),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    'Order Info',style: GoogleFonts.inter(
                    color: HexColor('#1D1E20'),
                    fontWeight: FontWeight.w500,
                    fontSize: 17.sp,

                  ),),
                  SizedBox(
                    height: 15.h,
                  ),
                  DetailsOfCart(text1: 'Subtotal', text2: "${controller.calctotal().round()}"),
                  SizedBox(
                    height: 10.h,
                  ),
                  DetailsOfCart(text1: 'Shipping cost', text2: '10'),
                  SizedBox(
                    height: 15.h,
                  ),
                  DetailsOfCart(text1: 'Total', text2: "${(controller.totalprice+10).round()}"),
                  SizedBox(
                    height: 20.h,
                  ),
                  Container(
                    height: 48.h,
                    decoration: BoxDecoration(
                      color: HexColor("#4A4E69"),
                      borderRadius: BorderRadius.circular(6.r)
                    ),
                    child: Center(
                      child: Text("Checkout",style: GoogleFonts.inter(
                        color: Colors.white,

                      )),
                    ),
                  )
                ],
              ),
              
            ),
          ),
        );
      }
    );*/
  }
}
