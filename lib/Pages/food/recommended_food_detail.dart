
import 'package:delivery/controllers/Recommended_product_controller.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../appcolors/colors.dart';
import '../../controllers/cart_controller.dart';
import '../../routes/routes_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_icons.dart';
import '../../widgets/big_text.dart';
import '../../widgets/expandable_text_widget.dart';
import '../home/cart/cart_page.dart';

class RecommendedFoodDetail extends StatelessWidget {
  final int pageId;
   const RecommendedFoodDetail({Key? key,required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product =Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<PopularProductController>().initProduct(product,Get.find<CartController>());
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap:(){
                      Get.toNamed(RouteHelper.initial);
      },
                    child: AppIcons(icon: Icons.clear)),
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
                //AppIcons(icon: Icons.shopping_cart)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(child: BigText(size:Dimensions.font26,text: product.name!)),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5,bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radius20),
                    topRight: Radius.circular(Dimensions.radius20)
                  )
                ),

              ),
            ),
            backgroundColor: AppColors.mainColor,
            pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
                width:double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  child: ExpandableTextWidget(text: product.description!,),
                  margin: EdgeInsets.only(left: Dimensions.width10,right: Dimensions.width10),
                )
              ],
            ),
          )
        ],
      ),
      bottomNavigationBar:GetBuilder<PopularProductController>(builder: (controller){
        return Column (
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20*2.5,
                  right: Dimensions.width20*2.5,
                  bottom: Dimensions.height10,
                  top: Dimensions.height10
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap:(){
                    controller.setQuantity(false);
        },
                    child: AppIcons(
                        iconSize: Dimensions.iconSize24,
                        backgroundColor:AppColors.mainColor,
                        iconcolor: Colors.white,
                        icon: Icons.remove),
                  ),

                  BigText(text: "\$. ${product.price!} X  ${controller.cartItems} ",color: AppColors.mainBlackColor,size: Dimensions.font26,),

                  GestureDetector(
                    onTap: (){
                      controller.setQuantity(true);
                    },
                    child: AppIcons(
                        iconSize: Dimensions.iconSize24,
                        backgroundColor:AppColors.mainColor,
                        iconcolor: Colors.white,
                        icon: Icons.add),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.height120,
              padding: EdgeInsets.only(top: Dimensions.height30,
                  bottom: Dimensions.height30,
                  right: Dimensions.width20,
                  left: Dimensions.width20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20*2),
                    topLeft: Radius.circular(Dimensions.radius20*2)
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
                    child: Icon(
                      Icons.favorite,
                      color: AppColors.mainColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      controller.AddItems(product);
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width10,right: Dimensions.width10),
                      child: BigText(
                        text: ("\$ ${product.price} | Add to Cart"),color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radius20),
                        color: AppColors.mainColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },)
    );
  }
}
