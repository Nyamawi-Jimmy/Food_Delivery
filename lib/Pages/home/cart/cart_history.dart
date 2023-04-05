import 'dart:convert';

import 'package:delivery/base/no_page_data.dart';
import 'package:delivery/models/cart_model.dart';
import 'package:delivery/routes/routes_helper.dart';
import 'package:delivery/utils/app_constants.dart';
import 'package:delivery/widgets/app_icons.dart';
import 'package:delivery/widgets/big_text.dart';
import 'package:delivery/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../appcolors/colors.dart';
import '../../../controllers/cart_controller.dart';
import '../../../utils/dimensions.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList=Get.find<CartController>()
        .getCartHistoryList().reversed.toList();
    Map<String ,int>cartItemsPerOrder =Map();

    for(int i=0;i<getCartHistoryList.length;i++){
      if(cartItemsPerOrder.containsKey(getCartHistoryList[i].time)){
        cartItemsPerOrder.update(getCartHistoryList[i].time!,(value)=>++value);

      }else{
        cartItemsPerOrder.putIfAbsent (getCartHistoryList[i].time!,()=>1);
      }
    }

    List<int>cartItemsPerOrderTimeTolist(){
      return cartItemsPerOrder.entries.map((e)=>e.value).toList();
    }
    List<String>cartOrderTimeTolist(){
      return cartItemsPerOrder.entries.map((e)=>e.key).toList();
    }

    List<int>itemsPerOrder=cartItemsPerOrderTimeTolist();//3/2/4
    var listCounter=0;
    Widget timeWidget(int index){
      var outputDate=DateTime.now().toString();
              if(index<getCartHistoryList.length){
                DateTime parseDate=DateFormat("yyyy-MM-dd hh:mm:ss" ).parse(getCartHistoryList[listCounter].time!);
                var inputDate= DateTime.parse(parseDate.toString());
                var outputFormat = DateFormat("dd/MM/yyyy hh:mm a");
                outputDate=outputFormat.format(inputDate);
              }
      return BigText(text:outputDate);
    }
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
            Container(
              height: Dimensions.height100,
              color: AppColors.mainColor,
              width: double.maxFinite,
              padding: EdgeInsets.only(top: Dimensions.height45),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BigText(text: "Cart History",color: Colors.white,),
                 // AppIcons(icon: Icons.shopping_cart_outlined,iconcolor: AppColors.mainColor,)
                ],
              ),
            ),
          GetBuilder<CartController>(builder: (_cartController){
            return _cartController.getCartHistoryList().length>0?Expanded(
                child: Container(
                    margin: EdgeInsets.only(
                        left: Dimensions.width10/2,
                        top:Dimensions.height20,
                        right: Dimensions.width10/2
                    ),

                    child: MediaQuery.removePadding(
                      removeTop: true,
                      context: context,
                      child: ListView(
                        children: [
                          for(int i=0; i<itemsPerOrder.length;i++)
                            Container(
                              height: Dimensions.height120,
                              margin: EdgeInsets.only(top: Dimensions.height20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  timeWidget(listCounter),
                                  SizedBox(height: Dimensions.height10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Wrap(
                                          direction: Axis.horizontal,
                                          children: List.generate(itemsPerOrder[i], (index){
                                            if (listCounter<getCartHistoryList.length){
                                              listCounter++;
                                            }
                                            return index<=2?Container(
                                              height: Dimensions.height20*4,
                                              width:Dimensions.height20*4,
                                              margin: EdgeInsets.only(right: Dimensions.width10/2),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                        AppConstants.BASE_URL+AppConstants.UPLOAD_URL+getCartHistoryList[listCounter-1].img!,
                                                      )
                                                  )
                                              ),
                                            ):Container();
                                          })
                                      ),
                                      Container(
                                        height: Dimensions.height20*4,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            SmallText(text: "Total",color: AppColors.titleColor,),
                                            BigText(text: itemsPerOrder[i].toString()+ " Items",color: AppColors.titleColor,),
                                            GestureDetector(
                                              onTap: (){
                                                var orderTime=cartOrderTimeTolist();
                                                Map<int ,CartModel> moreOrder={};
                                                for(int j=0; j<getCartHistoryList.length;j++){
                                                  if(getCartHistoryList[j].time==orderTime[i]){
                                                    moreOrder.putIfAbsent(getCartHistoryList[j].id!, () =>
                                                        CartModel.fromJson(jsonDecode(jsonEncode(getCartHistoryList[j])))
                                                    );
                                                  }
                                                }
                                                Get.find<CartController>().setItems=moreOrder;
                                                Get.find<CartController>().addToCartList();
                                                Get.toNamed(RouteHelper.getCartDetails());
                                              },
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: Dimensions.width20,vertical: Dimensions.height10/2),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.radius15/2),
                                                    border: Border.all(width: 1,color: AppColors.mainColor)
                                                ),
                                                child: SmallText(text: "One more",color: AppColors.mainColor,),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),

                            )
                        ],
                      ),)
                )):
            SizedBox(
                height: MediaQuery.of(context).size.height/1.5,
                child: const Center(
                    child: NoDataPage(text: "You didn't buy anything so far",imgPath: "assets/images/empty_box.jpg",)));
          })
        ],
      ),
    );
  }
}
