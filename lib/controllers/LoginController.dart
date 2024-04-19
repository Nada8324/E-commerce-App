import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/userdata.dart';
import '../shared/network/end_points.dart';
import '../shared/network/remote/diohelper.dart';

class LoginController extends GetxController{
  var Password_controller=TextEditingController();
  var Email_controller=TextEditingController();
  var formkey=GlobalKey<FormState>();
  var password=GlobalKey<FormFieldState>();
  var emailKey=GlobalKey<FormFieldState>();
  UserModel ?model;
  bool status = true;
  Future<void> userdata ({
    required String password,
    required String email,
  }) async {
    await DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':password,
    }).then((value) {
      model=UserModel.fromjson(value?.data);
      print(model?.status);
      print(model?.message);
      print(model?.data);
      update();
    });
  }
}