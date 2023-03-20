import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../appcolors/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/routes_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icons.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';
import '../../widgets/icon_and_text_widget.dart';
import '../../widgets/small_text.dart';
import '../home/cart/cart_page.dart';
import '../home/main_food_page.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  PopularFoodDetail({Key? key,required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product= Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //Background Image
          Positioned(
            left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.populaFoodImgSize350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                     AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!
                    )
                  )
                ),

          )),
          //Icon Widget
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:(){
                        if(page=="cart page"){
                          Get.toNamed(RouteHelper.getCartDetails());
                        }else{
                          Get.toNamed(RouteHelper.getInitial());
                        }
          },
                      child: AppIcons(icon: Icons.arrow_back_ios)),
                  GetBuilder<PopularProductController>(builder: (controller){
                    return GestureDetector(
                      onTap: (){
                        if(controller.totalItems>=1) {
                          Get.toNamed(RouteHelper.getCartDetails());
                        }
                      },
                      child: Stack(
                        children: [
                          AppIcons(icon: Icons.shopping_cart),
                          controller.totalItems>=1?
                      Positioned(
                          right:0,
                          top:0,
                            child: AppIcons(icon: Icons.circle,size:23,
                              iconcolor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,),
                          ):
                      Container(),
                          Get.find<PopularProductController>().totalItems>=1?
                          Positioned(
                              right:3,
                              top:1,
                              child:BigText(text: Get.find<PopularProductController>().totalItems.toString(),
                                size: 16,color: Colors.white,
                              ) ):
                          Container(),
                        ],
                      ),
                    );
                  })
                ],
              )),
          //Food Introduction
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.populaFoodImgSize350-20,
              child: Container(
                padding: EdgeInsets.only(left: Dimensions.width20,right: Dimensions.width20,top: Dimensions.height10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment:   CrossAxisAlignment.start,
                  children: [
                    AppColumn(text: product.name!,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce"),
                    //Expandable Text Widget
                    SizedBox(height: Dimensions.height10,),
                    Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text: product.description!))),
                  ],

                ),

          )),

        ],
      ),
      bottomNavigationBar: GetBuilder<PopularProductController>(builder: (popularproduct){
        return Container(
          height: Dimensions.height120,
          padding: EdgeInsets.only(top: Dimensions.height30,
              bottom: Dimensions.height30,
              right: Dimensions.width20,
              left: Dimensions.width20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius20*2),
              topLeft: Radius.circular(Dimensions.radius20*2),
            ),
            color: AppColors.buttonBackgroundColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width10,right: Dimensions.width10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap:(){
                          popularproduct.setQuantity(false);
        },
                        child: Icon(Icons.remove,color: AppColors.signColor,)),
                    SizedBox(width:Dimensions.width10),
                    BigText(text: popularproduct.cartItems .toString()),
                    SizedBox(width:Dimensions.width10),
                    GestureDetector(
                        onTap: (){
                          popularproduct.setQuantity(true);
                        },
                        child: Icon(Icons.add,color: AppColors.signColor,))

                  ],
                ),
              ),
              GestureDetector(
                onTap:(){
                  popularproduct.AddItems(product);
                },

                child: Container(
        padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width10,right: Dimensions.width10),
                    child: BigText(
                      text: ("\$.${product.price} | Add to Cart"),color: Colors.white,
                    ),

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                ),
              )
            ],
          ),
        );
      },)
    );
  }
}
