import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectx_task_shopapp/controllers/profile/cubit/cubit.dart';
import 'package:connectx_task_shopapp/controllers/profile/cubit/states.dart';
import 'package:connectx_task_shopapp/shared/component/component.dart';
import 'package:connectx_task_shopapp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getuser(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = ProfileCubit.get(context).userModel;
          ProfileCubit.get(context).EmailController.text = userModel!.email!;
          ProfileCubit.get(context).UserName_controller.text = userModel!.name!;

          var profileimage = ProfileCubit.get(context).image;
          var coverimage = ProfileCubit.get(context).coverimage;
          return ConditionalBuilder(
            condition: userModel!=null,
            fallback: (context) => CircularProgressIndicator(),
            builder: (context) =>Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                leading: Padding(
                  padding: EdgeInsetsDirectional.all(8),
                  child: CircleButton(
                    Iconsax.arrow_left,
                        () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                title: Text(
                  'Edit Profile',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                    color: HexColor("#1D1E20"),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      ProfileCubit.get(context).updateUserData(
                          name: ProfileCubit.get(context).UserName_controller.text,
                          email: ProfileCubit.get(context).EmailController.text);
                    },
                    child: Text(
                      'UPDATE',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                        color: Colors.blue[300],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is ShopUpdateLoadingstate)
                      LinearProgressIndicator(),
                    if (state is ShopUpdateLoadingstate)
                      SizedBox(
                        height: 10,
                      ),
                    Container(
                      height: 200,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: coverimage == null
                                              ? NetworkImage(
                                              "${userModel?.coverimage}")
                                              : FileImage(coverimage)
                                          as ImageProvider<Object>,
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(4.r),
                                        topRight: Radius.circular(4.r),
                                      )),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    ProfileCubit.get(context).pickCoverImage();
                                  },
                                  icon: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 20.0,
                                    child: Icon(
                                      IconBroken.Edit,
                                    ),
                                  ))
                            ],
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundImage: profileimage == null
                                      ? NetworkImage("${userModel?.image}")
                                  as ImageProvider<Object>?
                                      : FileImage(profileimage)
                                  as ImageProvider<Object>?,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  ProfileCubit.get(context).pickImage();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 20.0,
                                  child: Icon(
                                    IconBroken.Edit,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (ProfileCubit.get(context).image != null ||
                        ProfileCubit.get(context).coverimage != null)
                      Row(
                        children: [
                          if (ProfileCubit.get(context).image != null)
                            Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      ProfileCubit.get(context).UploadPofileImage(
                                        name: ProfileCubit.get(context).UserName_controller.text,
                                        email: ProfileCubit.get(context).EmailController.text,
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                          child: Text("Upload Profile Image")),
                                    ),
                                  ),
                              /*    if (state is ShopUpdateLoadingstate)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (state is ShopUpdateLoadingstate)
                                    LinearProgressIndicator()*/
                                ],
                              ),
                            ),
                          SizedBox(width: 10), // Adjust spacing as needed
                          if (ProfileCubit.get(context).coverimage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      ProfileCubit.get(context).UploadCoverImage(
                                        name: ProfileCubit.get(context).UserName_controller.text,
                                        email: ProfileCubit.get(context).EmailController.text,
                                      );
                                    },
                                    child: Container(
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.blue[100],
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Center(
                                          child: Text("Upload Cover Image")),
                                    ),
                                  ),
                                 /* if (state is ShopUpdateLoadingstate)
                                    SizedBox(
                                      height: 5,
                                    ),
                                  if (state is ShopUpdateLoadingstate)
                                    LinearProgressIndicator()*/
                                ],
                              ),
                            ),
                        ],
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      //key: cubit.userkey,
                      controller: ProfileCubit.get(context).UserName_controller,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#1D1E20"),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User name is required';
                        }
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(IconBroken.User),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue), // Change the color as needed
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                        label: Text(
                          'Username',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#8F959E"),
                          ),
                        ),

                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      //key: cubit.userkey,
                      controller: ProfileCubit.get(context).EmailController,
                      style: GoogleFonts.inter(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#1D1E20"),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'User phone is required';
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.message),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.blue), // Change the color as needed
                          borderRadius: BorderRadius.circular(
                              10.0), // Adjust the border radius as needed
                        ),
                        label: Text(
                          'Email',
                          style: GoogleFonts.inter(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#8F959E"),
                          ),
                        ),

                      ),
                    ),

                  ],
                ),
              ),
            ) ,

          );
        },
      ),
    );
  }
}
