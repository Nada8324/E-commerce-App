import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
      //controller.BuildProductItem(controller.model),
      // body is function BuildProductItem وبديها model كل ده موجود في الكونترولر بتاع البيدج
      bottomNavigationBar: SizedBox(
        height: 120,
      ),
      //child: controller.buildbottom(controller.model)),
      // add child buildbottom(model)
    );
  }
}
