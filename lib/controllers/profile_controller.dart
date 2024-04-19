import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import '../models/userdata.dart';
import '../shared/component/component.dart';
import '../shared/network/end_points.dart';
import '../shared/network/remote/diohelper.dart';
import '../shared/styles/icon_broken.dart';
import 'Layout_controller.dart';

class ProfileController extends GetxController{
  UserModel?Model;
  UserData? profilemodel;
  LayoutController layoutController=Get.put(LayoutController());
  void changeindex(int index){
    layoutController.index=index;
    update();
    layoutController.update();
  }
   @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    await DioHelper.getData(url: Profile,token: token).then((value) {
      Model=UserModel.fromjson(value.data);
      profilemodel=Model?.data;
      print(profilemodel?.name);
    }).then((value) {
      update();
    });
  }
  // Future<void> Logout ({
  //   required String token,
  // }) async {
  //   await DioHelper.postData(url: LOGIN, data: {
  //     'fcm_token':token,
  //   }).then((value) {
  //     model=UserModel.fromjson(value?.data);
  //     print(model?.status);
  //     print(model?.message);
  //     print(model?.data);
  //     update();
  //   });
  // }
  Widget buildMenuItems(BuildContext context) {
    return Container(
       color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(right: 7.0,left: 6,bottom: 8),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Iconsax.info_circle,
                color: HexColor("#1D1E20"),
                size: 25,),
              title: Text("Account Information", style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: HexColor("#1D1E20")
              ),),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Iconsax.lock4,
                color: HexColor("#1D1E20"),
                size: 25,),
              title: Text("Password", style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: HexColor("#1D1E20")
              ),),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(IconBroken.Bag,
                color: HexColor("#1D1E20"),
                size: 25,),
              title: Text("Order", style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: HexColor("#1D1E20")
              ),),
              onTap: () {
              changeindex(2);
              update();
              },
            ),
            ListTile(
              leading: Icon(Iconsax.wallet_2,
                color: HexColor("#1D1E20"),
                size: 25,),
              title: Text("My Cards", style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: HexColor("#1D1E20")
              ),),
              onTap: () {

              },
            ),
            ListTile(
              leading: Icon(Iconsax.heart4,
                color: HexColor("#1D1E20"),
                size: 25,),
              title: Text("Wishlist", style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: HexColor("#1D1E20")
              ),),
              onTap: () {
                changeindex(1);
                update();
              },
            ),
            ListTile(
              leading: Icon(Iconsax.setting_2,
                color: HexColor("#1D1E20"),
                size: 25,),
              title: Text("Settings", style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: HexColor("#1D1E20")
              ),),
              onTap: () {
               changeindex(3);
               update();
              },
            ),
            SizedBox(
              height: 40.h
            ),
            ListTile(
              leading: Icon(IconBroken.Logout,
                color: HexColor("#FF5757"),
                size: 25.r,),
              title: Text(
                "Logout", style: GoogleFonts.inter(
                  color: HexColor("#FF5757"),
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
              ),
              ),
              onTap: () {

              },
            ),
          ],
        ),
      ),
    );
  }
  Widget buildUserInfo(){
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 25.h,
            ),
            InkWell(
              splashColor: Colors.transparent,
              highlightColor:  Colors.transparent,
              onTap:() {
                Get.back();
              },
              child: CircleAvatar(
                radius: 22.5.r,
                backgroundColor: HexColor("#F5F6FA"),
                child: Icon(Icons.menu
                    ,color: HexColor("#1D1E20")),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Row(
              children: [
                CircleAvatar(
                    radius: 22.5.r,
                    backgroundColor: HexColor("#F5F5F5"),
                    child: Icon(Iconsax.profile_circle4,
                      size: 45,
                      color: HexColor("#1D1E20"),)

                ),
                SizedBox(
                  width: 15.w,
                ),
                Column(
                  children: [
                    Text("${profilemodel?.name}"
                        ,style: GoogleFonts.inter(
                          color: HexColor("#1D1E20"),
                          fontWeight: FontWeight.w500,
                          fontSize: 17.sp,
                        )),
                    Row(
                      children: [
                        Text("Verified Profile",
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#8F959E"),
                            )),
                        Image(image: AssetImage("assets/images/Badge.png")),
                      ],
                    )
                  ],
                ),
                Spacer(),
                Container(
                  height: 32.h,
                  width: 66.w,
                  decoration: BoxDecoration(
                    color: HexColor("#F5F5F5"),
                    borderRadius: BorderRadius.circular(5.r),
                  ),
                  child: Center(
                    child: Text("3 Orders",
                      style: GoogleFonts.inter(
                          color: HexColor("#8F959E"),
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30.h,
            ),

            Padding(
              padding: const EdgeInsets.only(left: 3.0),
              child: Row(
                children: [
                  Icon(Iconsax.sun_14,
                    color: HexColor("#1D1E20"),
                    size: 25,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text("Dark Mode",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 15.sp,
                        color: HexColor("#1D1E20")
                    ),),
                  Spacer(),
                  FlutterSwitch(
                    height: 25.h,
                    width: 45.w,
                    padding: 1.0,
                    toggleSize: 25.0.r,
                    borderRadius: 30.0.r,
                    activeColor: HexColor("#1D1E20"),
                    inactiveColor: HexColor("#D6D6D6"),
                    value: false,
                    onToggle: (value) {
                      value=!value;
                     update();
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}