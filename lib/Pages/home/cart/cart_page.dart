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
import 'package:mpesa_flutter_plugin/initializer.dart';
import 'package:mpesa_flutter_plugin/payment_enums.dart';

import '../../../base/no_page_data.dart';
import '../../../controllers/Recommended_product_controller.dart';
import '../../../controllers/auth_controller.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MpesaFlutterPlugin.setConsumerKey("mh5RDnQo11IE3KuGANLHGfhLtIIllCvj");
    MpesaFlutterPlugin.setConsumerSecret("VRcY3OsSjemjvHY8");
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
              GestureDetector(
                onTap:(){
                  Get.toNamed(RouteHelper.getInitial());
                },
                child: AppIcons(icon: Icons.arrow_back,
                iconcolor: Colors.white,
                  backgroundColor: AppColors.mainColor,
                  iconSize: Dimensions.iconSize24,
                ),
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
/*              AppIcons(icon: Icons.shopping_cart,
                iconcolor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24,
              )*/
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
                  /*onTap:(){
                    //popularproduct.AddItems(product);
                    print("tapped");
                    cartcontroller.addToHistory();
                  }*/
                  onTap: () {
                    startCheckout(
                        userPhone: "254718845069",
                        amount: cartcontroller.totalAmount);
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

  Future<void> startCheckout({required String userPhone, required int amount}) async {
    //Preferably expect 'dynamic', response type varies a lot!
    dynamic transactionInitialisation;
    //Better wrap in a try-catch for lots of reasons.
    try {
      //Run it
      transactionInitialisation =
      await MpesaFlutterPlugin.initializeMpesaSTKPush(
          businessShortCode: "174379",
          transactionType: TransactionType.CustomerPayBillOnline,
          amount: amount * 133.5,
          partyA: userPhone,
          partyB: "174379",
          callBackURL: Uri(scheme: "https", host : "sandbox.safaricom.co.ke"),
          accountReference: "Ordered Meal",
          phoneNumber: userPhone,
          baseUri: Uri(scheme: "https", host: "sandbox.safaricom.co.ke"),
          transactionDesc: "purchase",
          passKey: "bfb279f9aa9bdbcf158e97dd71a467cd2e0c893059b10f78e6b72ada1ed2c919");

      print("TRANSACTION RESULT: " + transactionInitialisation.toString());

      return transactionInitialisation;
    } catch (e) {
      //For now, console might be useful
      print("CAUGHT EXCEPTION: " + e.toString());


    }
  }
}
