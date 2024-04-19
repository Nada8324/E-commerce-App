import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import '../shared/component/component.dart';
import '../shared/styles/icon_broken.dart';
import '../view/Favorite_Screen.dart';
import '../view/cart_screen.dart';
import '../view/home_screen.dart';
import '../view/profile_screen.dart';

class LayoutController extends GetxController{
  int index=0;

  List<Widget> widget=[HomeScreen(),FavoriteScreen(),CartScreen(),ProfileScreen()];
    Widget buildbottom(){
     return  BottomNavigationBar(
       type: BottomNavigationBarType.fixed,
       elevation: 0,
       currentIndex: index,
       onTap: (value) {

         if(index<4) {
           index = value;
           update();
         }
         if(index==2) {
           Get.to(()=>CartScreen());
           index=0;
           update();
         }
       },
       selectedItemColor: HexColor("#4A4E69"),
       unselectedItemColor: HexColor("#8F959E"),
       backgroundColor: HexColor("#FEFEFE"),
       selectedLabelStyle: TextStyle(color: Colors.black),
       unselectedLabelStyle:  TextStyle(color: Colors.grey),
       selectedFontSize: 0,

       items: [
         BottomNavigationBarItem(icon: index!=0?Icon(IconBroken.Home)
             :Text("Home"),
             label: ''
         ),
         BottomNavigationBarItem(icon: index!=1?Icon(IconBroken.Heart):
         Text("Favorite"),
             label: ''),
         BottomNavigationBarItem(icon: index!=2?Icon(IconBroken.Bag):
         Text("Cart"),
             label:""),
         BottomNavigationBarItem(icon: index!=3?Icon(IconBroken.Profile):
         Text("Profile"),
             label:""),
       ],
     );
   }
}