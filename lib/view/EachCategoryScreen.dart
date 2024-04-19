import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/EachCategoryController.dart';
import '../shared/component/component.dart';
import '../shared/styles/icon_broken.dart';

class EachCategoryScreen extends StatelessWidget {
  const EachCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EachCategoryController>(
      init: EachCategoryController(),
      builder: (controller) {

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
                        Get.back();
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
                        controller.changeindex(2);
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
                // Text('${controller.name}',style: GoogleFonts.inter(color: HexColor("#1D1E20"),
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Container(
                      height: 50.h,
                      width: 275.w,
                      decoration: BoxDecoration(
                        color: HexColor("#F5F6FA"),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: TextFormField(
                          controller: controller.search_controller,
                          decoration: InputDecoration(
                              hintText: "Search...",hintStyle: GoogleFonts.inter(
                            color: HexColor("#8F959E"),
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w400,
                          ),
                              isDense: true,
                              prefixIcon:Icon( IconBroken.Search,color: HexColor('#8F959E'),size: 20.r),
                              border:  InputBorder.none
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 48.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: HexColor("#4A4E69"),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: IconButton(
                        icon: Icon(IconBroken.Voice,size: 24),
                        onPressed:() {

                        },
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              if(controller.Model==null) Expanded(child: Center(child: CircularProgressIndicator(color: Colors.black),)),
                if(controller.Model!=null) Expanded(
                  child: Container(
                    color: Colors.white,
                    child: GridView.count(
                      shrinkWrap: true,
                      mainAxisSpacing: 15.0.h,
                      crossAxisSpacing:15.0.w,
                      childAspectRatio: 1/1.7,
                      crossAxisCount: 2,
                      children: List.generate(controller.Model!.data!.products!.length
                          , (index) => controller.BuildProductItem(controller.Model!.data!.products![index])),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
