import 'package:delivery/Pages/home/main_food_page.dart';
import 'package:delivery/appcolors/colors.dart';
import 'package:delivery/controllers/cart_controller.dart';
import 'package:delivery/controllers/popular_product_controller.dart';
import 'package:delivery/routes/routes_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/utils/dimensions.dart';
import 'package:delivery/widgets/app_icons.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/no_page_data.dart';
import '../../../controllers/Recommended_product_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          //Header Icons
          Positioned(
              top: Dimensions.height20*3,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppIcons(icon: Icons.arrow_back,
              iconcolor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24,
              ),
              SizedBox(width:Dimensions.width20*5),
              GestureDetector(
                onTap: (){
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: AppIcons(icon: Icons.home_outlined,
                  iconcolor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
              ),
              AppIcons(icon: Icons.shopping_cart,
                iconcolor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24,
              )
            ],
          )),

          //Body Section
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getItems.length>0?Positioned(
                top: Dimensions.height20*5,
                left: Dimensions.width20,
                right: Dimensions.width20,
                bottom: 0,
                child: Container(
                  margin: EdgeInsets.only(top: Dimensions.height15),
                  //color: Colors.red,
                  child: MediaQuery.removePadding(
                      context:context,
                      removeTop: true,
                      child: GetBuilder<CartController>(builder: (cartcontroller){
                        var _cartlist=cartcontroller.getItems;
                        return ListView.builder(
                            itemCount:_cartlist.length,
                            itemBuilder: (_,index){
                              return Container(
                                height: Dimensions.height100,
                                width: double.maxFinite,
                                child: Row(
                                  children: [

                                    //showing images
                                    GestureDetector(
                                      onTap:(){
                                        var popularIndex=Get.find<PopularProductController>()
                                            .popularProductList.indexOf(_cartlist[index].product!);
                                        if (popularIndex>=0){
                                          Get.toNamed(RouteHelper.getPopularFood(popularIndex,"cart page"));
                                        }else{
                                          var recommendedIndex=Get.find<RecommendedProductController>()
                                              .recommendedProductList.indexOf(_cartlist[index].product!);
                                          if(recommendedIndex<0){
                                            Get.snackbar("History product", "Product review is not available for history products!",
                                                backgroundColor: AppColors.mainColor,
                                                colorText: Colors.white
                                            );

                                          }else{
                                            Get.toNamed(RouteHelper.getRecommendedFood(recommendedIndex,"cart page"));
                                          }
                                        }
                                      },
                                      child: Container(
                                        width: Dimensions.width20*5,
                                        height: Dimensions.height20*5,
                                        margin: EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit:BoxFit.cover,
                                                image: NetworkImage(
                                                  AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cartcontroller.getItems[index].img!,
                                                )
                                            ),
                                            borderRadius: BorderRadius.circular(Dimensions.radius20),
                                            color: Colors.white
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: Dimensions.width10,),
                                    //showing details
                                    Expanded(child: Container(
                                      height: Dimensions.height20*5,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          BigText(text: cartcontroller.getItems[index].name!,color: Colors.black54,),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(text:"\$"+cartcontroller.getItems[index].price.toString(),color: Colors.redAccent,),
                                              Container(
                                                padding: EdgeInsets.only(top: Dimensions.height10,bottom: Dimensions.height10,left: Dimensions.width10,right: Dimensions.width10),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  color: Colors.white,
                                                ),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                        onTap:(){
                                                          cartcontroller.AddItems(_cartlist[index].product!, -1);
                                                          // popularproduct.setQuantity(false);
                                                        },
                                                        child: Icon(Icons.remove,color: AppColors.signColor,)),
                                                    SizedBox(width:Dimensions.width10),
                                                    BigText(text:_cartlist[index].quantity.toString()), //popularproduct.cartItems .toString()),
                                                    SizedBox(width:Dimensions.width10),
                                                    GestureDetector(
                                                        onTap: (){
                                                          cartcontroller.AddItems(_cartlist[index].product!, 1);
                                                          // popularproduct.setQuantity(true);
                                                        },
                                                        child: Icon(Icons.add,color: AppColors.signColor,))

                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              );
                            });
                      },)
                  ),
                )):NoDataPage(text:"Your Cart is Empty",);
          })
        ],
      ),
        bottomNavigationBar: GetBuilder<CartController>(builder: (cartcontroller){
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
            child:cartcontroller.getItems.length>0? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width10,right: Dimensions.width10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BigText(text: "\$"+cartcontroller.totalAmount.toString()),

                    ],
                  )

                ),
                GestureDetector(
                  onTap:(){
                    //popularproduct.AddItems(product);
                    print("tapped");
                    cartcontroller.addToHistory();
                  },

                  child: Container(
                    padding: EdgeInsets.only(top: Dimensions.height20,bottom: Dimensions.height20,left: Dimensions.width10,right: Dimensions.width10),
                    child: BigText(
                      text: ("Check Out"),color: Colors.white,
                    ),

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                  ),
                )
              ],
            ):Container(),
          );
        },)
    );
  }
}
