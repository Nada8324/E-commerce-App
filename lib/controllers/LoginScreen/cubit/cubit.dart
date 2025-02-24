import 'package:connectx_task_shopapp/controllers/LoginScreen/cubit/states.dart';
import 'package:connectx_task_shopapp/shared/network/remote/diohelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>{
  ShopLoginCubit():super(ShopLoginInitialState());
  
  static ShopLoginCubit get(context)=>BlocProvider.of(context);
  String ?uId;
  var Password_controller=TextEditingController();
  var Email_controller=TextEditingController();
  var formkey=GlobalKey<FormState>();
  var password=GlobalKey<FormFieldState>();
  var emailKey=GlobalKey<FormFieldState>();
  Widget suffix_email=Icon(Icons.unpublished_outlined);

  bool status = false;
  IconData suffix=Icons.visibility_outlined;
  bool ispassword=true;
  Future<void> userdata ({
    required String password,
    required String email,
  }) async {
    emit(ShopLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    ).then((value) {
      emit(ShopLoginSuccessState(value.user!.uid));
      print(value.user?.email);
      print(value.user?.uid);
      uId=value.user?.uid;
    }).catchError((error){
      emit(ShopLoginErrorState(error.toString()));
    });
  }
  void Visibaltypassword()
  {
    ispassword=!ispassword;
    suffix=ispassword? Icons.visibility_outlined:Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
  void ChangeValueOfSwitch(bool value){
    status=value;
    emit(ShopLoginSwitchFalse());

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