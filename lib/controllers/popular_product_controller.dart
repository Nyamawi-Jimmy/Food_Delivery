import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appcolors/colors.dart';
import '../data/Repository/popular_product_repo.dart';
import '../models/cart_model.dart';
import '../models/products_model.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController{
    final PopularProductRepo popularProductRepo;

  PopularProductController({required this.popularProductRepo});
  List<dynamic> _popularProductList=[];
  List<dynamic> get popularProductList=>_popularProductList;
  late CartController _cart;

  int _quantity=0;
  int get quntity=>_quantity;
  int _cartItems=0;
  int get cartItems=>_cartItems+_quantity;

  Future<void> getPopularProductList()async {
  Response response= await popularProductRepo.getPopularProductList();
  print(response.request?.url);
  print(response.body);
  print(response.statusCode);
  if(response.statusCode==200){
    print(response.statusCode);
    _popularProductList=[];
    _popularProductList.addAll(Product.fromJson(response.body).products);

    update();

  } else {
    print(response.request?.url);
    print(response.body);
    print(response.statusCode);
  }
  }

  void setQuantity (bool isIncrement){
     if(isIncrement){
       _quantity=checkQuantity(_quantity+1);
       //print("the number of items added are"+_quantity.toString());

     }else{
       _quantity=checkQuantity(_quantity-1);
       //print("the number of items removed are"+_quantity.toString());
     }
     update();
  }
  int checkQuantity(int quantity){
    if (_cartItems+quantity<0){
      Get.snackbar("Item Count", "You can't reduce more!",
      backgroundColor: AppColors.mainColor,
        colorText: Colors.white
      );
      if (_cartItems>0){
        _quantity=-_cartItems;
        return _quantity;
      }
      return 0;
    }
    else if(_cartItems+quantity>20) {
      Get.snackbar("Item Count", "You can't add more!",
      backgroundColor: AppColors.mainColor,
          colorText: Colors.white
      );
      return 20;
    }
    else{
      return quantity;
    }
    }
    void initProduct(ProductModel product,CartController cart){
    _quantity=0;
    _cartItems=0;
    _cart=cart;
    var exist=false;
    exist=_cart.existInCart(product);

    //print("exist in cart or not" +exist.toString());

    if(exist){
      _cartItems=_cart.getQuantity(product);
    }
    //print("the number of items in the cart are "+_cartItems.toString());
}
void AddItems(ProductModel product,){

      _cart.AddItems(product,_quantity);
      _quantity=0;
      _cartItems=_cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        //print("the id is "+value.id.toString()+ " and the quantity is " +value.quantity.toString());
      });
update();

}

int get totalItems{
    return _cart.totalItems;
}

List<CartModel>get getItems{
  return _cart.getItems;
}
}



