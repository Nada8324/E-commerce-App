/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

import '../models/userdata.dart';
import '../shared/component/component.dart';
import '../shared/network/end_points.dart';
import '../shared/network/remote/diohelper.dart';
import '../view/login_screen.dart';

class SignUpController extends GetxController{
  var UserName_controller=TextEditingController();
  var Password_controller=TextEditingController();
  var Email_controller=TextEditingController();
  var Phone_controller=TextEditingController();
  bool get=false;
  var formkey=GlobalKey<FormState>();
  var password=GlobalKey<FormFieldState>();
  var emailKey=GlobalKey<FormFieldState>();
  var userkey=GlobalKey<FormFieldState>();
  UserModel ?model;
   String suffix_pass='weak';
  Widget suffix_user=Icon(Icons.unpublished_outlined);
  Widget suffix_email=Icon(Icons.unpublished_outlined);
  bool status = false;
  Future<void> userdata ({
    required String username,
    required String password,
    required String email,
    required String phone,
    required String image,
}) async {
   await DioHelper.postData(url: Register, data: {
     'name':username,
      'email':email,
      'password':password,
      'phone':phone,
     'image':image
    }).then((value) {
      print("ndhkdjlkjkljcldjsldlsklsld          kdjkdl.kfdls");
      model=UserModel.fromjson(value?.data);
      print(model?.status);
      print(model?.message);
      print(model?.data);

      update();
    });
  }
  void suffixicon_user(GlobalKey<FormFieldState> key) {
    if (key.currentState!.validate()){
      suffix_user=Icon(Icons.check);
    }
    else{
      suffix_user= Icon(Icons.unpublished_outlined);
    }
    update();
  }
  void suffixicon_pass(GlobalKey<FormFieldState> key) {
    if (key.currentState!.validate()) {
      suffix_pass = 'Strong';
    }
    else{
      suffix_pass='weak';
    }
    update();
  }
  void suffixicon_email(GlobalKey<FormFieldState> key) {
    if (key.currentState!.validate()){
      suffix_email=Icon(Icons.check);

    }
    else{
      suffix_email= Icon(Icons.unpublished_outlined);
    }
    update();
  }
}
*/
import 'dart:async';

import 'package:connectx_task_shopapp/controllers/LoginScreen/states.dart';
import 'package:connectx_task_shopapp/controllers/Signup/states.dart';
import 'package:connectx_task_shopapp/models/userdata.dart';
import 'package:connectx_task_shopapp/shared/network/end_points.dart';
import 'package:connectx_task_shopapp/shared/network/remote/diohelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wc_form_validators/wc_form_validators.dart';

class ShopRegosterCubit extends Cubit<ShopRegisterStates> {
  ShopRegosterCubit() : super(ShopRegisterInitialState());

  var UserName_controller=TextEditingController();
  var Password_controller=TextEditingController();
  var Email_controller=TextEditingController();
  var Phone_controller=TextEditingController();
  bool get=false;
  bool ispassword =true;
  IconData suffix=Icons.visibility_outlined;
  var formkey=GlobalKey<FormState>();
  var password=GlobalKey<FormFieldState>();
  var emailKey=GlobalKey<FormFieldState>();
  var userkey=GlobalKey<FormFieldState>();
  UserModel ?model;
  String suffix_pass='weak';
  Widget suffix_user=Icon(Icons.unpublished_outlined);
  Widget suffix_email=Icon(Icons.unpublished_outlined);
  bool status = false;
  /*Future<void> userdata ({
    required String username,
    required String password,
    required String email,
    required String phone,
    required String image,
  }) async {
    emit(ShopRegisterInitialState());
    await DioHelper.postData(url: Register, data: {
      'name':username,
      'email':email,
      'password':password,
      'phone':phone,
      'image':image
    }).then((value) {
      print("ndhkdjlkjkljcldjsldlsklsld          kdjkdl.kfdls");
      model=UserModel.fromjson(value?.data);
      print(model?.status);
      print(model?.message);
      print(model?.data);
      emit(ShopRegisterSuccessState());

    }).catchError((error)
    {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }*/
  void suffixicon_user(GlobalKey<FormFieldState> key) {
    if (key.currentState!.validate()){
      suffix_user=Icon(Icons.check);
    }
    else{
      suffix_user= Icon(Icons.unpublished_outlined);
    }
    emit(ShopRegisterChangeUserIconState());
  }
  void suffixicon_pass(GlobalKey<FormFieldState> key) {
    if (key.currentState!.validate()) {
      suffix_pass = 'Strong';
    }
    else{
      suffix_pass='weak';
    }
    emit(ShopRegisterChangePasswordIconState());
  }
  void suffixicon_email(GlobalKey<FormFieldState> key) {
    if (key.currentState!.validate()){
      suffix_email=Icon(Icons.check);

    }
    else{
      suffix_email= Icon(Icons.unpublished_outlined);
    }
    emit(ShopRegisterChangeEmailIconState());
  }

  void Visibaltypassword()
  {
    ispassword=!ispassword;
    suffix=ispassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
  emit(ShopRegisterChangeEyeIconState());
  }
  void ChangeValueOfSwitch(bool value){
    status=value;
    emit(ShopRegisterChangeSwitch());
  }
}
