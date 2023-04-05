import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/routes/routes_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Pages/auth/register.dart';
import 'Pages/auth/sign_in.dart';
import 'Pages/auth/sign_up.dart';
import 'Pages/home/food_page_body.dart';
import 'Pages/splash/splash_page.dart';
import 'controllers/Recommended_product_controller.dart';
import 'controllers/popular_product_controller.dart';
import 'helper/dependencies.dart' as dep;
import 'Pages/home/main_food_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<CartController>().getCartData();
    return GetBuilder<PopularProductController>(builder: (_){
      return GetBuilder<RecommendedProductController>(builder: (_){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Delivery',
          //home:SignUpPage(),
          initialRoute: RouteHelper.getSplashPage(),
          getPages: RouteHelper.routes,
        );
      });
    });
  }
}

