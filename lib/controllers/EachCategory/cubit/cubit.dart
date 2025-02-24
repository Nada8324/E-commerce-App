

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectx_task_shopapp/controllers/Details/DetailsScreen.dart';
import 'package:connectx_task_shopapp/controllers/EachCategory/cubit/states.dart';
import 'package:connectx_task_shopapp/controllers/Home/cubit/states.dart';
import 'package:connectx_task_shopapp/models/productmodel.dart';
import 'package:connectx_task_shopapp/shared/component/component.dart';
import 'package:connectx_task_shopapp/shared/network/end_points.dart';
import 'package:connectx_task_shopapp/shared/network/remote/diohelper.dart';
import 'package:connectx_task_shopapp/view/EachCategoryScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:iconsax/iconsax.dart';

class CategoryCubit extends Cubit<ShopCategoryStates>{
  static CategoryCubit get(context) =>BlocProvider.of(context);
  CategoryCubit():super(ShopCategoryInitialState());

  EachCategoryModel ?Model;
  var search_controller=TextEditingController();
  void getCategoryProduct(){
    emit(ShopCategoryLoadingState());
     DioHelper.getData(url: Products,query: {
      'category_id':EachCategoryScreen.id,
    },token: token
    ).then((value)async {
      Model=EachCategoryModel.fromjson(value?.data);
    await  getFavoriteProducts(token!);
      Model!.data!.products!.forEach((element1) {
        ListOfFavorite.forEach((element2) {
           if(element1.id==element2.id){
             element1.in_favorites=true;
           }
        });
      });
      emit(ShopCategorySuccessState());
    }).catchError((error){
      emit(ShopCategoryErrorState(error.toString()));
      print(error.toString());
     });
  }
  final CollectionReference<Map<String, dynamic>> productsCollection =
  FirebaseFirestore.instance.collection('products');
  Future<void> toggleFavoriteProduct(String userId, ProductsModel product) async {
    final favoriteDoc = await productsCollection.doc(userId).collection('favorites').doc(product.id.toString()).get();
    emit(DetailsToogleLoading());
    if (favoriteDoc.exists) {
      product.in_favorites=false;
      await productsCollection.doc(userId).collection('favorites').doc(product.id.toString()).delete();
      emit(DeatilsAddToWishList());
    } else {
      product.in_favorites=true;

      await productsCollection.doc(userId).collection('favorites').doc(product.id.toString()).set(product.toMap());
      emit(DeatilsAddToWishList());
    }
  }
  Widget BuildProductItem(ProductsModel model,BuildContext context){
    //bool? fav=model.in_favorites;
    return Container(
      color: Colors.white,
      child: InkWell(
        onTap: () {
          DetailsScreen.productsModel=model;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image(image: NetworkImage(
                    "${model.image}"
                ),
                    height: 203.h,
                    width: 160.w,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      else {
                        return Container(
                          height: 203.h,
                          width: 160.w,
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.black),
                          ),
                        );
                      }
                    }
                ),
                InkWell(
                  onTap: () {

                    CategoryCubit.get(context).toggleFavoriteProduct(token!,model); // Handle favorite toggle here

                  },
                  child: model.in_favorites!?Icon(Iconsax.heart5):Icon(Iconsax.heart),
                ),

              ],
            ),
            SizedBox(
              height: 5.h,
            ),
            Container(
              height: 35,
              child: Text('${model.name}',style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 11.sp,
                color: HexColor("#1D1E20"),
              ),maxLines: 2,overflow: TextOverflow.ellipsis),
            ),
            Row(
              children: [
                Text('${model.price}',style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  color: HexColor("#1D1E20"),
                )),
                if(model.price!=model.old_price)
                  SizedBox(width: 5.w,),
                if(model.price!=model.old_price)
                  Text(
                    '${model.old_price}', style: GoogleFonts.inter(
                      color: HexColor("#8F959E"),
                      fontSize: 12.sp,
                      decoration: TextDecoration.lineThrough
                  ),),
                if(model.price!=model.old_price)
                  Spacer(),
                if(model.price!=model.old_price)
                  Text(
                    '${model.discount}%', style: GoogleFonts.inter(
                    color: Colors.green,
                    fontSize: 13.sp,

                  ),),

              ],
            ),

          ],
        ),
      ),
    );
  }
}