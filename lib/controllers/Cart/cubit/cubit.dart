import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectx_task_shopapp/controllers/Cart/cubit/state.dart';
import 'package:connectx_task_shopapp/controllers/Details/DetailsScreen.dart';
import 'package:connectx_task_shopapp/shared/component/component.dart';
import 'package:connectx_task_shopapp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class CartCubit extends Cubit<cartStates>{
  CartCubit():super(cartinit());
  static CartCubit get(context) =>BlocProvider.of(context);


/*  Widget builditem(ProductsModel productsModel,int index,BuildContext context){
    return Container(
      height: 120.h,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 10,vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 20.r,

            offset: Offset(4, 8), // Shadow position
          ),
        ],
        color: index==0?HexColor("#FEFEFE"):HexColor("#F5F6FA"),
      ),

      child: InkWell(
        onTap: () {
          DetailsScreen.productsModel=productsModel;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(),
            ),
          );        },
        child: Row(

          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: 100.w,
              //height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r)
              ),
              child: Image(image: NetworkImage(productsModel.image!),

                //fit: BoxFit.cover,
                loadingBuilder:(context, child, loadingProgress)  {
                  if(loadingProgress==null){
                    return child;
                  }
                  else{
                    return Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  }
                },),
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 137.w,
                      child: Text(
                        productsModel.name!,
                        style:GoogleFonts.inter(
                          color:  HexColor("#1D1E20"),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 2,

                        overflow: TextOverflow.ellipsis,),
                    ),
                    SizedBox(height: 10.h,),
                    Text('\$${productsModel.price}(+${(productsModel.price*0.02).round()} Tax)',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 11.sp,
                          color: HexColor("#8F959E"),
                        )),

                    Expanded(
                      child: Row(
                        children: [
                          InkWell(

                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: HexColor("#DEDEDE")
                                  )
                              ),
                              child: Icon(IconBroken.Arrow___Down_2,color: HexColor("#8F959E")),


                            ),
                              onTap: () {
                                int newQuantity = model.quantity!- 1;
                                if (newQuantity <= 0) {

                                  FirebaseFirestore.instance
                                      .collection('cart')
                                      .doc(token)
                                      .collection('items')
                                      .doc(productsModel.id.toString())
                                      .delete()
                                      .then((_) {
                                    print('Item deleted from cart.');
                                  })
                                      .catchError((error) {
                                    print('Error deleting item from cart: $error');
                                  });
                                } else {
                                  // Update item quantity in the cart
                                  FirebaseFirestore.instance
                                      .collection('cart')  // Replace 'carts' with your collection name
                                      .doc(token)       // Replace 'userId' with the user's ID
                                      .collection('items')
                                      .doc(productsModel.id.toString())
                                      .update({'quantity': newQuantity})
                                      .then((_) {
                                    // Quantity updated successfully
                                    print('Quantity updated in cart.');
                                  })
                                      .catchError((error) {
                                    // Error updating quantity
                                    print('Error updating quantity in cart: $error');
                                  });
                                }
                              }

                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Text('${model.quantity}',style: GoogleFonts.inter(
                            color: HexColor("#1D1E20"),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          InkWell(

                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: HexColor("#DEDEDE")
                                  )
                              ),
                              child: Icon(IconBroken.Arrow___Up_2,color: HexColor("#8F959E")),

                            ),
                            onTap: () {
                              model.quantity=model.quantity!+1;
                              update();
                            },
                          ),
                          Spacer(),
                          InkWell(
                            child: Container(
                              width: 25.w,
                              height: 25.h,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: HexColor("#DEDEDE")
                                  )
                              ),
                              child: Icon(IconBroken.Delete,size: 15,color: HexColor("#8F959E")),

                            ),
                            onTap: () {
                              changecart(model.product!.id);
                              cartModel?.data?.cartItems?.remove(model);
                              update();
                            },
                          )
                        ],
                      ),
                    ),
                    //     maxLines: 3),
                  ],

                ),
              ),
            ),
            // Icon(IconBroken.Bookmark)

          ],

        ),

      ),
    );

  }
  int calctotal(){
    cartModel?.data?.cartItems?.forEach((model) {
      totalprice+=model.quantity!*(model.product?.price+model.product?.price*0.02);

    });
    return totalprice.round();
  }*/
}