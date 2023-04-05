import 'dart:async';

import 'package:delivery/utils/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../controllers/Recommended_product_controller.dart';
import '../../controllers/popular_product_controller.dart';
import '../../routes/routes_helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin{

  late Animation<double> animation;
  late AnimationController controller;
 Future<void> _loadReosurces() async {
      await Get.find<PopularProductController>().getPopularProductList();
      await Get.find<RecommendedProductController>().getRecommendedProductList();
  }


  @override
  void initState(){
    super.initState();

        _loadReosurces();
        controller=AnimationController(vsync: this,duration: Duration(seconds: 2))..forward();
        animation=CurvedAnimation(parent: controller, curve: Curves.linear);
        
        Timer(
            const Duration(seconds: 3),
          ()=>Get.offNamed(RouteHelper.signin)
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(child: Image.asset("assets/images/logo.png"))),
        ],
      ),
    );
  }
}
