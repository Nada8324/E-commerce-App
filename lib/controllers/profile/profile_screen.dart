import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectx_task_shopapp/controllers/Editprofile/EditProfileScreen.dart';
import 'package:connectx_task_shopapp/controllers/Layout/cubit/cubit.dart';
import 'package:connectx_task_shopapp/controllers/Layout/cubit/states.dart';
import 'package:connectx_task_shopapp/controllers/profile/cubit/cubit.dart';
import 'package:connectx_task_shopapp/controllers/profile/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';


import '../../shared/styles/icon_broken.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return BlocProvider(
       create: (context) => ProfileCubit()..getuser(),
       child: BlocConsumer<ProfileCubit,ProfileStates>(
         listener: (context, state) {},
         builder: (context, state) {
           var userModel=ProfileCubit.get(context).userModel;
           return ConditionalBuilder(
             condition: userModel!=null,
             builder:(context) => Scaffold(
               appBar: AppBar(
                 backgroundColor: Colors.white,
                 title: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                     'Profile',
                     style: GoogleFonts.inter(
                       fontWeight: FontWeight.w800,
                       fontSize: 20.sp,
                       color: HexColor("#1D1E20"),
                     ),
                     maxLines: 2,
                     overflow: TextOverflow.ellipsis,
                   ),
                 ),
               ),
                 body: SingleChildScrollView(
                   child: Padding(
                     padding: EdgeInsetsDirectional.all(10),
                     child: Column(
                       children: [
                         Container(
                           height:200 ,
                           child: Stack(
                             alignment: AlignmentDirectional.bottomCenter,
                             children: [
                               Align(

                                 alignment: AlignmentDirectional.topCenter,

                                 child: Container(
                                   height: 150,
                                   width: double.infinity,
                                   decoration: BoxDecoration(
                                       image: DecorationImage(
                                           image: NetworkImage("${userModel?.coverimage}"),
                                           fit: BoxFit.cover
                                       ),
                                       borderRadius: BorderRadius.only(
                                         topLeft: Radius.circular(4.r),
                                         topRight: Radius.circular(4.r),

                                       )

                                   ),

                                 ),
                               ),
                               CircleAvatar (
                                 radius: 65,
                                 backgroundColor: Colors.white,
                                 child: CircleAvatar(
                                   radius: 60,
                                   backgroundImage: NetworkImage("${userModel?.image}"),
                                 ),
                               ),

                             ],
                           ),
                         ),
                         SizedBox(
                           height: 5,
                         ),
                         Row(
                           children: [
                             Text(
                               'Name: ',
                               style: GoogleFonts.inter(
                                 fontWeight: FontWeight.w600,
                                 fontSize: 20.sp,
                                 color: HexColor("#1D1E20"),
                               ),
                               maxLines: 2,
                               overflow: TextOverflow.ellipsis,
                             ),
                             SizedBox(width: 10,),
                             Text(
                               '${userModel?.name}',
                               style: GoogleFonts.inter(
                                 fontWeight: FontWeight.w600,
                                 fontSize: 20.sp,
                                 color: HexColor("#1D1E20"),
                               ),
                               maxLines: 2,
                               overflow: TextOverflow.ellipsis,
                             ),
                           ],
                         ),
                         SizedBox(
                           height:5,
                         ),
                         Row(
                           children: [
                             Text(
                               'Email: ',
                               style: GoogleFonts.inter(
                                 fontWeight: FontWeight.w600,
                                 fontSize: 20.sp,
                                 color: HexColor("#1D1E20"),
                               ),
                               maxLines: 2,
                               overflow: TextOverflow.ellipsis,
                             ),
                             SizedBox(width: 10,),
                             Text(
                               '${userModel?.email}',
                               style: GoogleFonts.inter(
                                 fontWeight: FontWeight.w600,
                                 fontSize: 18.sp,
                                 color: HexColor("#1D1E20"),
                               ),
                               maxLines: 1,
                               overflow: TextOverflow.ellipsis,
                             ),
                           ],
                         ),
                         SizedBox(
                           height:5,
                         ),
                         Row(
                           children: [
                             Text(
                               'Phone: ',
                               style: GoogleFonts.inter(
                                 fontWeight: FontWeight.w600,
                                 fontSize: 20.sp,
                                 color: HexColor("#1D1E20"),
                               ),
                               maxLines: 2,
                               overflow: TextOverflow.ellipsis,
                             ),
                             SizedBox(width: 10,),
                             Text(
                               '${userModel?.phone}',
                               style: GoogleFonts.inter(
                                 fontWeight: FontWeight.w600,
                                 fontSize: 20.sp,
                                 color: HexColor("#1D1E20"),
                               ),
                               maxLines: 2,
                               overflow: TextOverflow.ellipsis,
                             ),
                           ],
                         ),
                         SizedBox(
                           height:5,
                         ),
                         InkWell(
                           onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileScreen(),));
                           },
                           child: Container(
                             height: 40,
                             width: double.infinity,

                             decoration: BoxDecoration(
                                 color: Colors.blue[100],
                                 borderRadius: BorderRadius.circular(4)

                             ),
                             child: Center(child: Text("Edit Profile")),
                           ),
                         ),
                         //ProfileCubit.get(context).buildUserInfo(context),
                         ProfileCubit.get(context).buildMenuItems(context)
                       ],
                     ),
                   ),
                 )
               // add like design in menu screen and functions in profile controller
             ),
             fallback: (context) => Center(child: CircularProgressIndicator()),
           );
         },
       ),
     );
  }
}

