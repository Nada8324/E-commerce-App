import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectx_task_shopapp/controllers/Cart/cart_screen.dart';
import 'package:connectx_task_shopapp/controllers/Favourite/Favorite_Screen.dart';
import 'package:connectx_task_shopapp/controllers/Home/home_screen.dart';
import 'package:connectx_task_shopapp/controllers/Layout/cubit/cubit.dart';
import 'package:connectx_task_shopapp/controllers/Layout/cubit/states.dart';
import 'package:connectx_task_shopapp/controllers/Signup/UserModel/userdata.dart';
import 'package:connectx_task_shopapp/controllers/profile/profile_screen.dart';
import 'package:connectx_task_shopapp/shared/component/component.dart';
import 'package:connectx_task_shopapp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class Shopcubit extends Cubit<ShopState>
{
  Shopcubit():super(ShopInitState());

  static Shopcubit get(context) =>BlocProvider.of(context);
  int index=0;

  List<Widget> widget=[HomeScreen(),FavoriteScreen(),CartScreen(),ProfileScreen()];
  void changeindex(int value){
    index=value;
    emit(ShopChangeIndex());
  }

  Widget buildbottom(){
    return  BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      currentIndex: index,
      onTap: (value) {
       changeindex(value);
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