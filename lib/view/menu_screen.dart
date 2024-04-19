import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';


import '../controllers/profile_controller.dart';
import '../shared/styles/icon_broken.dart';

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return Drawer(
          backgroundColor: HexColor("#FFFFFF"),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              controller.buildUserInfo(),
              controller.buildMenuItems(context),
              Expanded(
                child: Container(

                  color: Colors.white,
                ),
              )
            ],
          ),
        );
      }
    );


  }

}
// List<Widget> r=[rowofsetting(text: "Account Information", icon: Iconsax.info_circle, function:(){}),
//   rowofsetting(text: "Password", icon: Iconsax.lock4, function:(){}),
//   rowofsetting(text: "Order", icon: IconBroken.Bag, function:(){
//
//   }),
//   rowofsetting(text: "My Cards", icon: Iconsax.wallet_2, function:(){
//
//   }),
//   rowofsetting(text: "Wishlist", icon: Iconsax.heart4, function:(){
//
//   }),
//   rowofsetting(text: "Settings", icon: Iconsax.setting_2, function:(){
//
//   }),
//   SizedBox(
//     height: 127.h,
//   ),
//   InkWell(
//     onTap: () {
//
//     },
//     child: Row(
//       children: [Icon(
//         IconBroken.Logout,
//         color: HexColor("#FF5757"),
//         size: 25.r,
//       ),
//         SizedBox(
//           width: 5.w,
//         ),
//         Text("Logout",style: GoogleFonts.inter(
//             color: HexColor("#FF5757"),
//             fontSize: 15.sp,
//             fontWeight: FontWeight.w500
//         ),)
//       ],
//     ),
//   )
//
// ];
// return Drawer(
//   child: ListView.separated(itemBuilder: (context, index) {
//     return r[index];
//   },
//     separatorBuilder: (context, index) {
//       return SizedBox(
//         height: 20.h,
//       );
//     }, itemCount: r.length,
//   ),
// );
