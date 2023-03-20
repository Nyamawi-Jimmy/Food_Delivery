import 'package:delivery/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../appcolors/colors.dart';
import '../data/Repository/cart_repo.dart';
import '../models/cart_model.dart';

class CartController extends GetxController{
final CartRepo cartRepo;
CartController({required this.cartRepo});
Map<int, CartModel>_items={};

Map<int, CartModel>get items=>_items;

void AddItems(ProductModel product, int quantity){
  var totalQuantity=0;
 if(_items.containsKey(product.id!)){
        _items.update(product.id!, (value) {
          totalQuantity=value.quantity!+quantity;
            return CartModel(
                id:value.id,
                name:value.name,
                price:value.price,
                img:value.img,
                quantity:value.quantity!+quantity,
                isExist:true,
                time:DateTime.now().toString(),
              product: product,
            );
        });
        if(totalQuantity<=0){
          _items.remove(product.id);
        }
 }else{
   if(quantity>0){
     _items.putIfAbsent(product.id!, () {
       return CartModel(
         id:product.id,
         name:product.name,
         price:product.price,
         img:product.img,
         quantity:quantity,
         isExist:true,
         time:DateTime.now().toString(),
         product: product,
       );}
     );
   }else{
     Get.snackbar("Item Count", "Atleast add one item to the cart!",
         backgroundColor: AppColors.mainColor,
         colorText: Colors.white
     );
   }
 }
  update();
 }

bool existInCart(ProductModel product){
  if(_items.containsKey(product.id)){
    return true;
  }
  return false;
}

getQuantity(ProductModel product){
  var quantity=0;
  if(_items.containsKey(product.id)){
    _items.forEach((key, value) {
      if(key==product.id!){
        quantity=value.quantity!;
      }
    });
  }
  return quantity;
}

int get totalItems{
  var totalQuantity=0;
  _items.forEach((key, value) {
    totalQuantity+=value.quantity!;
  });
  return totalQuantity;
}

List<CartModel>get getItems{
  return _items.entries.map((e) {
    return e.value;
  }).toList();
}

 int get totalAmount{
  var total=0;
  _items.forEach((key, value) {
    total+=value.price!*value.quantity!;
  });
  return total;
 }

}
