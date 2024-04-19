import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../controllers/Layout_controller.dart';
import '../shared/styles/icon_broken.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
       init: LayoutController(),
      builder: (controller) {
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
