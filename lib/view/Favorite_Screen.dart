import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';


import '../shared/component/component.dart';
import '../shared/styles/icon_broken.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Row(
                  children: [
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor:  Colors.transparent,
                      onTap:() {
                       //controller.changeindex(0);
                        // اللي هو ارجع اللهوم changeindex(0)  هنادي علي فانكشن
                      },
                      child: CircleAvatar(
                        radius: 22.5.r,
                        backgroundColor: HexColor("#F5F6FA"),
                        child: Icon(Iconsax.arrow_left
                            ,color: HexColor("#1D1E20")),
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor:  Colors.transparent,
                      onTap:() {
                        //controller.changeindex(2);
                        // call change index function (2) (go to cart screen)
                      },
                      child: CircleAvatar(
                        radius: 22.5.r,
                        backgroundColor: HexColor("#F5F6FA"),
                        child: Icon(IconBroken.Bag
                            ,color: HexColor("#1D1E20")),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  //'${controller.getFavModel!.data!.total} Items',
                  'num of total items ',
                  style: GoogleFonts.inter(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                  color: HexColor("#1D1E20"),
                ),),
                SizedBox(
                  height: 5.h,
                ),
                Text('in wishlist',style: GoogleFonts.inter(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#8F959E"),
                ),),
                MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Container(

                    width: double.infinity,
                    child: ListView.separated(
                      itemCount: 3,
                      //itemCount: controller.getFavModel!.data!.data!.length
                      // add lengh of list contain favourites
                      //,itemBuilder: (context, index) => controller.BuildFavItem(controller.getFavModel!.data!.data![index]),
                      // add item builder function
                      itemBuilder: (context, index) => Container(),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 15.h,
                      ),
                      shrinkWrap: true,
                    ),
                  ),
                ),

              ],
            ),
          ),
        );

  }
}
