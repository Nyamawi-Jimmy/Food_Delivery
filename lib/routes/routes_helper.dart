import 'package:delivery/Pages/food/popular_food_detail.dart';
import 'package:delivery/Pages/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../Pages/food/recommended_food_detail.dart';
import '../Pages/home/cart/cart_page.dart';

class RouteHelper{
  static const String initial="/";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartDetails="/cart-details";

  static String getInitial()=>"$initial";
  static String getPopularFood(int pageId)=>"$popularFood?pageId=$pageId";
  static String getRecommendedFood(int pageId)=>"$recommendedFood?pageId=$pageId";
  static String getCartDetails()=>"$cartDetails";

  static List<GetPage> routes=[
  GetPage(name: initial, page: ()=>MainFoodPage()),
  GetPage(name: popularFood, page:(){
    var pageId=Get.parameters["pageId"];
    return PopularFoodDetail(pageId:int.parse(pageId!));
  },
  transition:Transition.fadeIn
  ),
    GetPage(name: recommendedFood, page:(){
      var pageId=Get.parameters["pageId"];
      return RecommendedFoodDetail(pageId:int.parse(pageId!));
    },
        transition:Transition.fadeIn
    ),
  GetPage(name: cartDetails, page:(){
  return CartPage();
  },
  transition:Transition.fadeIn
  )
  ];
}