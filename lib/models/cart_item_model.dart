
import '../shared/component/component.dart';

class CartModel {
  bool? status;
  String? message;
  Data? data;

  CartModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }
}

class Data {
  List<CartItems>? cartItems;
  Data.fromJson(Map<String, dynamic> json) {
    if (json['cart_items'] != null) {
      cartItems = <CartItems>[];
      json['cart_items'].forEach((v) {
        cartItems!.add(new CartItems.fromJson(v));
      });
    }
  }
}

class CartItems {
  int? id;
  int? quantity;
  ProductsModel? product;
  CartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
    product =
    json['product'] != null ? new ProductsModel.fromjson(json['product']) : null;
  }
}
