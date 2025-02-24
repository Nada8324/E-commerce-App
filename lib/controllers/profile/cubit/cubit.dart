import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectx_task_shopapp/controllers/Layout/cubit/cubit.dart';
import 'package:connectx_task_shopapp/controllers/LoginScreen/login_screen.dart';
import 'package:connectx_task_shopapp/controllers/Signup/UserModel/userdata.dart';
import 'package:connectx_task_shopapp/controllers/profile/cubit/states.dart';
import 'package:connectx_task_shopapp/shared/component/component.dart';
import 'package:connectx_task_shopapp/shared/network/local/cache_helper.dart';
import 'package:connectx_task_shopapp/shared/styles/icon_broken.dart';
import 'package:connectx_task_shopapp/view/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileCubit extends Cubit<ProfileStates>{
  ProfileCubit():super(GetUserInit());
  static ProfileCubit get(context) =>BlocProvider.of(context);
  UserModel ?userModel;

  var UserName_controller = TextEditingController();


  var EmailController = TextEditingController();


  void getuser(){
    emit(GetUserLoading());
    FirebaseFirestore.instance
        .collection('users')
        .doc(token)
        .get()
        .then((value) {
      print(value.data());
      userModel = UserModel.fromjson(value.data?.call() ?? {});
      print(userModel);
      emit(GetUserSuccess());
    }).catchError((error){
      emit(GetUserError(error.toString()));
      print(error.toString());

    });
  }
  File? coverimage;
  Future pickCoverImage()async{
    final coverimage=await ImagePicker().pickImage(source: ImageSource.gallery);
    if(coverimage==null){
      emit(ShopCoverPickedErrorState());
      return;
    }
    final imageTemporary=File(coverimage!.path);
    this.coverimage=imageTemporary;
    emit(ShopCoverPickedSuccessState());
  }
  File? image;

Future pickImage()async{
  final image=await ImagePicker().pickImage(source: ImageSource.gallery);
  if(image==null){
    emit(ShopimagePickedErrorState());
    return;
  }
  final imageTemporary=File(image!.path);
  this.image=imageTemporary;
  emit(ShopimagePickedSuccessState());
}


void UploadPofileImage({required String name,
  required String email,
}){
  //emit(ShopUpdateLoadingstate());
  firebase_storage.FirebaseStorage
      .instance.ref()
      .child('users/${Uri.file(image!.path)
      .pathSegments.last}')
      .putFile(image!)
      .then((value) {
        value.ref.getDownloadURL().then((value) {
          print("image is ${value}");
          emit(ShopUploadimageSuccessState());
          updateUserData(
              name: name,
              email: email,
              image: value,
          );
        }).catchError((error){
          emit(ShopUploadimageErrorState());
        });
      }).catchError((error){
    emit(ShopUploadimageErrorState());
    print(error.toString());

  });

}

void UploadCoverImage({
  required String name,
  required String email,
}){
 // emit(ShopUpdateLoadingstate());
   firebase_storage.FirebaseStorage
      .instance.ref()
      .child('users/${Uri.file(coverimage!.path)
      .pathSegments.last}')
      .putFile(coverimage!)
      .then((value) {
    value.ref.getDownloadURL().then((value) {
      print("cover is ${value}");
      emit(ShopUploadCoverSuccessState());
        updateUserData(name: name,
         email: email,cover: value);
    }).catchError((error){
      emit(ShopUploadCoverErrorState());
      print(error.toString());
    });
  }).catchError((error){
    emit(ShopUploadCoverErrorState());
    print(error.toString());
  });

}


void updateUserData({
  required String name,
  required String email,
  String ?cover,
  String ?image,
}){
  emit(ShopUpdateLoadingstate());
  UserModel model=UserModel(
    name: name,
    email: email,
    isverefied: userModel!.isverefied,
    phone: userModel!.phone,
    uId: userModel!.uId,
    image:image?? userModel!.image,
    coverimage:cover?? userModel!.coverimage,
  );
  FirebaseFirestore
      .instance
      .collection('users')
      .doc(userModel?.uId)
      .update(model.toMap())
      .then((value) {
    getuser();
  });

 }


  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print('Password reset email sent to $email');
    } catch (error) {
      print('Error sending password reset email: $error');
      throw error;
    }
  }


  Widget buildMenuItems(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(right: 7.0,left: 6,bottom: 8),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Iconsax.lock4,
                color: HexColor("#1D1E20"),
                size: 25,),
              title: Text("Reset Password", style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp,
                  color: HexColor("#1D1E20")
              ),),
              onTap: () {
                resetPassword(userModel!.email!);
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
               Shopcubit.get(context).changeindex(2);
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
                Shopcubit.get(context).changeindex(1);
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
                CacheHelper.deleteToken(key: token!);
                Navigator.push(context,MaterialPageRoute(builder: (context) => SignupScreen(),));
              },
            ),
          ],
        ),
      ),
    );
  }
}

