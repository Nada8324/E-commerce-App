import 'package:connectx_task_shopapp/controllers/Layout/cubit/cubit.dart';
import 'package:connectx_task_shopapp/controllers/Layout/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../shared/styles/icon_broken.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
         return BlocConsumer<Shopcubit,ShopState>(
           listener: (context, state) {

           },
           builder: (context, state) {
             var controller=Shopcubit.get(context);
             return Scaffold(
               backgroundColor: HexColor("#FEFEFE"),
               body: controller.widget[controller.index],
               bottomNavigationBar: SizedBox(
                   height: 80.h,
                   child:controller.buildbottom()
               ),
               drawer: Drawer(
                 child: ListView(
                   children: [
                     ListTile(

                     )
                   ],
                 ),
               ),
             );
           },
         );
      }
}
