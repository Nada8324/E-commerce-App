import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectx_task_shopapp/controllers/Details/DetailsScreen.dart';
import 'package:connectx_task_shopapp/controllers/Favourite/cubit/state.dart';
import 'package:connectx_task_shopapp/shared/component/component.dart';
import 'package:connectx_task_shopapp/shared/styles/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class FavCubit extends Cubit<FavStates>{

  static FavCubit get(context) =>BlocProvider.of(context);

  FavCubit():super(favinit());
  bool done=false;
  void getdata()async{
    emit(favLoadData());
    ListOfFavorite=[];
    await getFavoriteProducts(token!);
    done=true;
    emit(getdataf());
  }
  final CollectionReference<Map<String, dynamic>> productsCollection =
  FirebaseFirestore.instance.collection('products');
  Future<void> toggleFavoriteProduct(String userId, ProductsModel product) async {
    final favoriteDoc = await productsCollection.doc(userId).collection('favorites').doc(product.id.toString()).get();
    emit(favload());
    if (favoriteDoc.exists) {
      product.in_favorites=false;
      await productsCollection.doc(userId).collection('favorites').doc(product.id.toString()).delete();
      emit(favsuccess());
    } else {
      product.in_favorites=true;

      await productsCollection.doc(userId).collection('favorites').doc(product.id.toString()).set(product.toMap());
      emit(favsuccess());
    }
  }

List<ProductsModel> product_list_deleted=[];
Widget BuildFavItem(ProductsModel productsModel,BuildContext context) {
  return Dismissible(
    direction: DismissDirection.endToStart,
    key: Key(productsModel.id!.toString()),
    onDismissed: (direction){
      FavCubit.get(context).toggleFavoriteProduct(token!,productsModel);
      ListOfFavorite.forEach((element) {
        if(element.id==productsModel.id)
        {

        }
        else{
          product_list_deleted.add(element);
          FavCubit.get(context).toggleFavoriteProduct(token.toString(), productsModel);
        }
      });
      emit(favchange());
      ListOfFavorite=product_list_deleted;

      //update();
    },

    background: Container(
      width: double.infinity,
      color: Colors.white,
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Icon(Iconsax.heart_remove),
      ),
    ),
    child: Container(
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
        color: HexColor("#FEFEFE"),
      ),

      child: InkWell(
        onTap: () {
          DetailsScreen.productsModel=productsModel;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(),
            ),
          );
        },
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

                //fit: BoxFit.scaleDown,
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
                    SizedBox(height: 4.h,),
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
                    Spacer(),
                    //SizedBox(height: 20.h,),
                    Row(
                      children: [
                        Text('\$${productsModel.price}(+${(productsModel.price*0.02).round()} Tax)',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400,
                              fontSize: 11.sp,
                              color: HexColor("#8F959E"),
                            )),
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
                            FavCubit.get(context).toggleFavoriteProduct(token.toString(), productsModel);
                            ListOfFavorite.remove(productsModel);

                          },
                        )
                      ],
                    ),
                    SizedBox(height: 6.h,)
                  ],

                ),
              ),
            ),
            // Icon(IconBroken.Bookmark)

          ],

        ),

      ),
    ),
  );
}
}