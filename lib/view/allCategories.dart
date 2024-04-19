import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

import '../controllers/allcategoriescontroller.dart';
import '../shared/component/component.dart';
import '../shared/styles/icon_broken.dart';
import 'Layout_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
   AllCategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllCategoriesController>(
      init: AllCategoriesController(),
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
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
                          Get.to(LayoutScreen());
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
                  ListView.separated(shrinkWrap: true,itemBuilder: (context, index) {
                   return controller.BuildCategoryItem(controller.list[index]);
                  }, separatorBuilder: (context, index) {
                    return   Padding(padding: EdgeInsets.all(10),
                        child: Container(height: 1,color: Colors.grey[200],));
                  }, itemCount: controller.list.length),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
