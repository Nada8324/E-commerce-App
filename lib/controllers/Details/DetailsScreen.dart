import 'package:connectx_task_shopapp/controllers/Layout/cubit/cubit.dart';
import 'package:connectx_task_shopapp/shared/component/component.dart';
import 'package:connectx_task_shopapp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatefulWidget {

  static  ProductsModel? productsModel;

   DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int indexx=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BuildProductItem(DetailsScreen.productsModel!,context),
      bottomNavigationBar: SizedBox(
        height: 120,
        child:buildbottom(DetailsScreen.productsModel!),
      ),
    );
  }

  Widget BuildProductItem(ProductsModel model,BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                alignment: AlignmentDirectional.center,
                height: 380.h,
                child: Image(
                  image: NetworkImage("${model.image}"),
                  fit: BoxFit.contain,
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 45,left: 20.0,right: 20),
                child: Row(
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

                  ],
                ),
              ),

            ],
          ),
          SizedBox(
            height: 2.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    child: Text('${model.name}',style: GoogleFonts.inter(
                      color: HexColor("#1D1E20"),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text('Price',style: GoogleFonts.inter(
                      color: HexColor("#8F959E"),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    ),
                    Text('\$${model.price}',style: GoogleFonts.inter(
                      color: HexColor("#1D1E20"),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    ),
                    if(model.price!=model.old_price)
                      Row(
                        children: [
                          Text('\$${model.old_price}',style: GoogleFonts.inter(
                              color: HexColor("#8F959E"),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough
                          ),
                          ),
                          SizedBox(width: 5.w),
                          Text('${model.discount}%',style: GoogleFonts.inter(
                            color: Colors.green,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                          ),
                          ),
                        ],
                      ),
                  ],
                ),
              ],
            ),
          ),
          if(model.images!=null) Padding(
            padding: EdgeInsets.all(20),
            child: Container(
              height: 100,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return images(model.images![index],DetailsScreen.productsModel!);
                },
                itemCount: model.images!.length,
                separatorBuilder: (context, index) {
                  return SizedBox(width: 9);
                },
              ),
            ),
          ),
          if(model.images==null) SizedBox(
            height: 3.h,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text('Description',style: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              fontSize: 17.sp,
              color: HexColor("#1D1E20"),
            ),),
          ),
          SizedBox(
            height:10.h ,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: ReadMoreText(
              "${model.description}",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 15.sp,
                color: HexColor("#8F959E"),
              ),
              trimLines: 3,
              trimCollapsedText: 'Read More..',
              trimExpandedText: 'Read less',
              colorClickableText: HexColor("#1D1E20"),
              trimMode: TrimMode.Line,
              lessStyle:GoogleFonts.inter(color: HexColor("#1D1E20"),fontSize: 15.sp, fontWeight: FontWeight.w600),
              moreStyle:GoogleFonts.inter(color: HexColor("#1D1E20"),fontSize: 15.sp, fontWeight: FontWeight.w600),
              delimiter: '',
            ),
          ),
          SizedBox(
              height:  10.h
          ),
          //Spacer(),


        ],
      ),
    );
  }

  Widget buildbottom(ProductsModel model){
    return Padding(
      padding: const EdgeInsets.only(right: 20,left: 20,bottom: 20,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Price',style: GoogleFonts.inter(
                      color: HexColor("#1D1E20"),
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w600
                  ),),
                  Text('with VAT,SD',style: GoogleFonts.inter(
                      color: HexColor("#8F959E"),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400
                  ),),
                ],
              ),
              Spacer(),
              Text('\$${(model.price+(model.price*.02)).round()}',style: GoogleFonts.inter(
                  color: HexColor("#1D1E20"),
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600
              ),),


            ],
          ),
          InkWell(
            onTap: () {
              //changecart(model.id);

              // changeindex(2);
              // Get.to(LayoutScreen());

            },
            child: Container(

              height: 48.h,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: HexColor("#4A4E69"),
                  borderRadius: BorderRadius.circular(6)
              ),
              child: Center(
                child: Text(
                  'Add to cart',
                  style: GoogleFonts.inter(
                    color: HexColor("#FFFFFF"),
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

  }

  Widget images(dynamic image,ProductsModel model){
    return InkWell(
      onTap: () {
         setState(() {
           model.image=image;
         });
        //update();
      },
      child: Container(
        width: 100,
        height: 100,

        decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(10.r)
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child:Image(
          image: NetworkImage("${image}"),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}



