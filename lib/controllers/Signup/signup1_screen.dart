import 'package:connectx_task_shopapp/controllers/Layout/Layout_screen.dart';
import 'package:connectx_task_shopapp/controllers/LoginScreen/login_screen.dart';
import 'package:connectx_task_shopapp/controllers/Signup/cubit/cubit.dart';
import 'package:connectx_task_shopapp/controllers/Signup/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:wc_form_validators/wc_form_validators.dart';
import '../../shared/component/component.dart';

class Signup1Screen extends StatelessWidget {
  Signup1Screen({Key? key}) : super(key: key);
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegosterCubit(),

      child: BlocConsumer<ShopRegosterCubit,ShopRegisterStates>(
        listener: (context, state) {
            if (state is ShopCreateUserSuccessState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen(),));
            }
        },
        builder: (context, state) {
          final cubit = BlocProvider.of<ShopRegosterCubit>(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key:cubit.formkey ,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 45.h,
                      ),
                      CircleButton(Iconsax.arrow_left,(){
                        Navigator.pop(context);
                      }),
                      SizedBox(
                        height: 15.h,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text('Sign Up',
                          style: GoogleFonts.inter(
                            color: HexColor("#1D1E20"),
                            fontSize: 28.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 90.h,
                      ),
                      TextFormField(
                        key: cubit.userkey,
                        controller: cubit.UserName_controller,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#1D1E20"),
                        ),
                        validator: (value) {
                          if(value!.isEmpty){
                            return 'User name is required';
                          }
                        },
                        keyboardType:TextInputType.name ,
                        onChanged: (value) {
                          cubit.suffixicon_user(cubit.userkey);

                        },
                        decoration: InputDecoration(
                          label: Text(
                            'Username',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#8F959E"),
                            ),
                          ),
                          suffixIcon:cubit.suffix_user,
                          suffixIconColor: HexColor("#4A4E69"),
                          suffixStyle: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#8F959E"),
                          ),

                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        key:cubit.password,
                        controller: cubit.Password_controller,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#1D1E20"),
                        ),

                        validator: Validators.compose([
                          Validators.required('Password is required'),
                          Validators.patternString(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$', 'Invalid Password')
                        ]
                        ),
                        keyboardType:TextInputType.visiblePassword ,
                        onChanged: (value) {
                          cubit.suffixicon_pass(cubit.password);
                        },
                        decoration: InputDecoration(

                          label: Text(
                            'Password',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#8F959E"),
                            ),
                          ),
                          suffixText:cubit.suffix_pass,
                          suffixIconColor: HexColor("#4A4E69"),
                          suffixStyle: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#8F959E"),
                          ),

                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(
                        controller: cubit.Phone_controller,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#1D1E20"),
                        ),

                        validator: Validators.compose([
                          Validators.required('Phone number is required'),
                        ]
                        ),
                        keyboardType:TextInputType.phone ,

                        decoration: InputDecoration(

                          label: Text(
                            'Phone number',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#8F959E"),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      TextFormField(

                        key: cubit.emailKey,
                        controller: cubit.Email_controller,
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: HexColor("#1D1E20"),
                        ),
                        validator: Validators.compose([
                          Validators.required('Email Adress is required'),
                          Validators.email('Invalid Email Adress')
                        ]
                        ),
                        keyboardType:TextInputType.visiblePassword ,
                        onChanged: (value) {
                          cubit.suffixicon_email(cubit.emailKey);

                        },
                        decoration: InputDecoration(

                          label: Text(
                            'Email Address',
                            style: GoogleFonts.inter(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: HexColor("#8F959E"),
                            ),
                          ),
                          suffixIcon:cubit.suffix_email,
                          suffixIconColor: HexColor("#4A4E69"),
                          suffixStyle: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#8F959E"),
                          ),
                        ),
                      ),


                      SizedBox(
                        height: 90.h,
                      ),
                      Center(
                        child: InkWell (
                          onTap: ()async{
                            if(cubit.formkey.currentState!.validate()){
                              cubit.userdata(username: cubit.UserName_controller.text,
                                  password: cubit.Password_controller.text,
                                  email:cubit.Email_controller.text,
                                  phone:cubit.Phone_controller.text,
                                  image: 'sss');
                            }
                          },
                          child: Container(
                            width: 107.w,
                            height: 48.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              color: HexColor("#4A4E69"),
                            ),
                            child: Center(
                              child: Text(
                                "Sign up",
                                style: GoogleFonts.inter(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}