import 'package:connectx_task_shopapp/controllers/Layout/cubit/cubit.dart';
import 'package:connectx_task_shopapp/controllers/Layout/cubit/states.dart';
import 'package:connectx_task_shopapp/models/category_model.dart';
import 'package:connectx_task_shopapp/view/EachCategoryScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';


import '../shared/component/component.dart';
import '../shared/styles/icon_broken.dart';
import '../controllers/Layout/Layout_screen.dart';

class AllCategoriesScreen extends StatelessWidget {
  static List<DataModel>? data;
   AllCategoriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
        return BlocProvider(
          create: (context) => Shopcubit(),
          child: BlocConsumer<Shopcubit,ShopState>(
            listener: (context, state) {

            },
            builder: (context, state) {
              var LayoutController = Shopcubit.get(context);

              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        Row(
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor:  Colors.transparent,
                              onTap:() {
                                Navigator.pop(context);
                              },
                              child: CircleAvatar(
                                radius: 22.5.r,
                                backgroundColor: HexColor("#F5F6FA"),
                                child: Icon(Iconsax.arrow_left
                                    ,color: HexColor("#1D1E20")),
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              splashColor: Colors.transparent,
                              highlightColor:  Colors.transparent,
                              onTap:(){
                                LayoutController.changeindex(2);
                              },
                              child: CircleAvatar(
                                radius: 22.5.r,
                                backgroundColor: HexColor("#F5F6FA"),
                                child: Icon(IconBroken.Bag
                                    ,color: HexColor("#1D1E20")),
                              ),
                            ),
                          ],
                        ),
                        ListView.separated(shrinkWrap: true,itemBuilder: (context, index) {
                          return BuildCategoryItem(data![index],context);
                        }, separatorBuilder: (context, index) {
                          return   Padding(padding: EdgeInsets.all(10),
                              child: Container(height: 1,color: Colors.grey[200],));
                        }, itemCount: data!.length),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
  }
  Widget BuildCategoryItem(DataModel model,BuildContext context){
    return Container(
      height: 100,
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20)
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Image(image: NetworkImage("${model.image}"),
              fit: BoxFit.cover,

            ),
          ),
          SizedBox(
            width: 10.w,
          ),
          Text('${model.name}',style: GoogleFonts.inter(
            color: HexColor("#1D1E20"),
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
          ),),
          Spacer(),
          InkWell(
              onTap: () {
                EachCategoryScreen.id=model.id;
                EachCategoryScreen.name=model.name;
                EachCategoryScreen.image=model.image;
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>
                        EachCategoryScreen(),));
              },child: Icon(Iconsax.arrow_right_3)),
        ],
      ),
    );
  }
}
