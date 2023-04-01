import 'package:delivery/Pages/food/popular_food_detail.dart';
import 'package:delivery/Pages/home/main_food_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../Pages/auth/register.dart';
import '../Pages/auth/sign_in.dart';
import '../Pages/auth/sign_up.dart';
import '../Pages/food/recommended_food_detail.dart';
import '../Pages/home/cart/cart_page.dart';
import '../Pages/home/home_page.dart';
import '../Pages/splash/splash_page.dart';

class RouteHelper{
  static const String signup="/signup";
  static const String signin="/signin";
  static const String initial="/";
  static const String splashScreen="/splash-screen";
  static const String popularFood="/popular-food";
  static const String recommendedFood="/recommended-food";
  static const String cartDetails="/cart-details";

  static String getInitial()=>"$initial";
  static String getSplashPage()=>"$splashScreen";
  static String getPopularFood(int pageId,String page)=>"$popularFood?pageId=$pageId&page=$page";
  static String getRecommendedFood(int pageId,String page)=>"$recommendedFood?pageId=$pageId&page=$page";
  static String getCartDetails()=>"$cartDetails";

  static List<GetPage> routes=[
  GetPage(name: initial, page: ()=>HomePage()),
    GetPage(name: splashScreen, page: ()=>SplashPage()),
  GetPage(name: popularFood, page:(){
    var pageId=Get.parameters["pageId"];
    var page=Get.parameters["page"];
    return PopularFoodDetail(pageId:int.parse(pageId!),page:page!);
  },
  transition:Transition.fadeIn
  ),
    GetPage(name: recommendedFood, page:(){
      var pageId=Get.parameters["pageId"];
      var page=Get.parameters["page"];
      return RecommendedFoodDetail(pageId:int.parse(pageId!),page:page!);
    },
        transition:Transition.fadeIn
    ),
  GetPage(name: cartDetails, page:(){
  return CartPage();
  },
  transition:Transition.fadeIn
  ),

    //Plan B
   GetPage(name: RouteHelper.signup,
       page:()=>SignUpPage()
   ),
    GetPage(name: RouteHelper.signin,
        page:()=>SignInPage()
    )

  ];
}