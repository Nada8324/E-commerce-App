import 'package:connectx_task_shopapp/controllers/LoginScreen/states.dart';
import 'package:connectx_task_shopapp/models/userdata.dart';
import 'package:connectx_task_shopapp/shared/network/remote/diohelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginInitialState());
  
  static ShopLoginCubit get(context)=>BlocProvider.of(context);

  var Password_controller=TextEditingController();
  var Email_controller=TextEditingController();
  var formkey=GlobalKey<FormState>();
  var password=GlobalKey<FormFieldState>();
  var emailKey=GlobalKey<FormFieldState>();
  Widget suffix_email=Icon(Icons.unpublished_outlined);
  UserModel ?model;
  bool status = true;
  IconData suffix=Icons.visibility_outlined;
  bool ispassword=true;
  Future<void> userdata ({
    required String password,
    required String email,
  }) async {
   /* emit(ShopLoginLoadingState());
    await DioHelper.postData(url: LOGIN, data: {
      'email':email,
      'password':password,
    }).then((value) {
      model=UserModel.fromjson(value?.data);
      print(model?.status);
      print(model?.message);
      print(model?.data);
      update();
    });*/
  }
  void Visibaltypassword()
  {
    ispassword=!ispassword;
    suffix=ispassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
  void ChangeValueOfSwitch(bool value){
    status=value;
    emit(ShopLoginChangeSwitch());
  }
  void suffixicon_email(GlobalKey<FormFieldState> key) {
    if (key.currentState!.validate()){
      suffix_email=Icon(Icons.check);

    }
    else{
      suffix_email= Icon(Icons.unpublished_outlined);
    }
    emit(ShopLoginChangeEmailIconState());
  }
}