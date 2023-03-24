import 'dart:convert';

import 'package:delivery/utils/app_constants.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo{
final SharedPreferences sharedPreferences;
CartRepo({required this.sharedPreferences});

List<String> cart=[];
List<String>cartHistory=[];

void addToCartList(List<CartModel>cartlist){
  sharedPreferences.remove(AppConstants.CART_LIST);
  sharedPreferences.remove(AppConstants.CART_HISTORY_LIST );
  var time=DateTime.now().toString();
  cart=[];
  //converting objects to string because shared preferences only accepts strings
cartlist.forEach((element) {
  element.time=time;
  return cart.add(jsonEncode(element));

});

  sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
  //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  //getCartList();

}

List<CartModel> getCartList(){

  List<String> carts=[];

  if(sharedPreferences.containsKey(AppConstants.CART_LIST)){
        carts=sharedPreferences.getStringList(AppConstants.CART_LIST)!;
        print("inside get cartlist"+carts.toString());
  }else{

  }
  List<CartModel> cartlist=[];

      carts.forEach((element)=>cartlist.add(CartModel.fromJson(jsonDecode(element))));


  return cartlist;

}

List<CartModel> getCartHistoryList(){
  if(sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
    cartHistory=[];
    cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
  }
  List<CartModel> cartListHistory=[];

  cartHistory.forEach((element)=>cartListHistory.add(CartModel.fromJson(jsonDecode(element))));
return cartListHistory;
}

void addToCartHistoryList(){
  if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)){
    cartHistory=sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
  }
  for (int i=0; i<cart.length; i++){
    print("history list"+cart[i]);
    cartHistory.add(cart[i]);
  }
  removeCart();
  sharedPreferences.setStringList(AppConstants.CART_HISTORY_LIST, cartHistory);
  print("the length of the history list is "+getCartHistoryList().length.toString());
  for(int j=0; j<getCartHistoryList().length;j++){
    print("the time of the history list is "+getCartHistoryList()[j].time.toString());
  }

}
void removeCart(){
  cart=[];
  sharedPreferences.remove(AppConstants.CART_LIST);
}
}
