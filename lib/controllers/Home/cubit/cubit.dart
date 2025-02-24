import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectx_task_shopapp/controllers/Details/DetailsScreen.dart';
import 'package:connectx_task_shopapp/controllers/Home/cubit/states.dart';
import 'package:connectx_task_shopapp/controllers/Home/homeModel/HomeModel.dart';
import 'package:connectx_task_shopapp/models/category_model.dart';
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

class HomeCubit extends Cubit<HomeScreenStates>
{
  HomeCubit():super(HomeInitState());
  static HomeCubit get(context) =>BlocProvider.of(context);
  var search_controller=TextEditingController();
  CategoryModel ?categoryModel;
  HomeModel ?homeModel;
  List<DataModel> categoryitemlist=[];

  List<ProductsModel>prductItemList=[];
  Icon fav=Icon(Iconsax.heart);
  void getHomeData() async{
   // print("get home");
    emit(HomeProductsLoadingState());
    await DioHelper.getData(url: Home,token: token
    ).then((value) async {
      homeModel=HomeModel.fromjson(value.data);
      prductItemList=homeModel!.data!.products!;
      await getFavoriteProducts(token!);
      prductItemList.forEach((element1) {
        ListOfFavorite.forEach((element2) {
          if(element1.id==element2.id){
            element1.in_favorites=true;
          }
        });
      });
      emit(HomeProductsSuccessState());
    }).catchError((error){
      emit(HomeProductsErrorState(error.toString()));
      print(error.toString());
     });
  }

  void getCategories()async{
    emit(HomecatLoadingState());
    await DioHelper.getData(url: Categories).then((value) {
      categoryModel=CategoryModel.Fromjson(value.data);
      categoryitemlist=categoryModel!.data!.data!;
     emit(HomecatSuccessState());
    }).catchError((error){
      emit(HomeCatErrorState(error.toString()));
      print(error.toString());
    });
  }


  final CollectionReference<Map<String, dynamic>> productsCollection =
  FirebaseFirestore.instance.collection('products');
  Future<void> toggleFavoriteProduct(String userId, ProductsModel product) async {
      final favoriteDoc = await productsCollection.doc(userId).collection('favorites').doc(product.id.toString()).get();
       emit(ToogleLoading());
      if (favoriteDoc.exists) {
         product.in_favorites=false;
        await productsCollection.doc(userId).collection('favorites').doc(product.id.toString()).delete();
        emit(RemoveFromWishList());
      } else {
        product.in_favorites=true;

        await productsCollection.doc(userId).collection('favorites').doc(product.id.toString()).set(product.toMap());
        emit(AddToWishList());
      }
    }
  Widget buildProductItem(ProductsModel model, BuildContext context) {
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
                Image(
                  image: NetworkImage("${model.image}"),
                  height: 203.h,
                  width: 160.w,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Container(
                        height: 203.h,
                        width: 160.w,
                        child: Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                      );
                    }
                  },
                ),
                InkWell(
                  onTap: () {
                    HomeCubit.get(context).toggleFavoriteProduct(token!,model); // Handle favorite toggle here
                  },
                  child:model.in_favorites==true?Icon(Iconsax.heart5):Icon(Iconsax.heart),
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Container(
              height: 35,
              child: Text(
                '${model.name}',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 11.sp,
                  color: HexColor("#1D1E20"),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Text(
                  '${model.price}',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13.sp,
                    color: HexColor("#1D1E20"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget build_category_item(DataModel model,BuildContext context){
    return InkWell(
      onTap: () {
        EachCategoryScreen.id=model.id;
        EachCategoryScreen.name=model.name;
        EachCategoryScreen.image=model.image;
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                EachCategoryScreen(),));

      },
      child: Container(
        height: 60.h,
        width: 140.w,
        decoration: BoxDecoration(
          color: HexColor("#F5F6FA"),
          borderRadius: BorderRadius.circular(10),

        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image(image: NetworkImage("${model.image}"),
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      else {
                        return Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        );
                      }
                    }
                ),
              ),
            ),
            SizedBox(
              width: 10.h,
            ),
            Text('${model.name}',style: GoogleFonts.inter(
                color: HexColor("#1D1E20"),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
            ),)
          ],
        ),
      ),
    );
  }

  }




  /*void changeindex(int index){
    layoutController.index=index;
    update();
    layoutController.update();
  }*/
